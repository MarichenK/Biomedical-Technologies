
import 'package:agri_fit/Utilities/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Impact{

  static String baseUrl = 'https://impact.dei.unipd.it/bwthw/';
  static String pingEndpoint = 'gate/v1/ping/'; //pings the server
  static String tokenEndpoint = 'gate/v1/token/'; //takes user credentials and generates associated access 
  static String refreshEndpoint = 'gate/v1/refresh/'; //generates new access
  static String deleteUser = 'gate/v1/deactivate/{username}/'; //deletes user
  static String activateUser = 'gate/v1/activate/{username}/'; //activates new user
  static String changePsW = 'gate/v1/change_password/'; //changes password
  
  static String stepsEndpoint = 'data/v1/steps/patients/';
  static String caloriesEndpoint = 'data/v1/calories/patients/';

  static String username = '89XOcHGVfL';
  static String password = '12345678!';

  static String patientUsername = 'Jpefaq6m58';
}

class ServerStrings {
  //JWT
  static const issClaim = 'backend-impact';
  static const researcherRoleIdentifier = 'researcher';

  //URL
  static const backendBaseUrl = 'https://impact.dei.unipd.it/bwthw/';
  static const authServerUrl = 'gare/v1/';
  static const apiServerUrl = 'api/v1/';
}

class ImpactService {
  ImpactService(this.prefs) {
    updateBearer();
  }

  Preferences prefs;

  final Dio _dio = Dio(BaseOptions(baseUrl: ServerStrings.backendBaseUrl));

  String? retrieveSavedToken(bool refresh){
    if (refresh) {
      return prefs.impactRefreshToken;
    } else {
      return prefs.impactAccessToken;
    }
  }

  bool checkSavedToken({bool refresh = false}){
    String? token = retrieveSavedToken(refresh);
    if (token == null) {
      return false;
    }
    try {
      return ImpactService.checkToken(token);
    } catch (_) {
      return false;
    }
  }

  static bool checkToken(String token){
    if (JwtDecoder.isExpired(token)) {
      return false;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    if (decodedToken['iss'] == null){
      return false;
    } else {
      if (decodedToken['iss'] != ServerStrings.issClaim) {
        return false;
      }
    }

    if (decodedToken['role'] == null) {
      return false;
  } else {
    if (decodedToken['role'] != ServerStrings.researcherRoleIdentifier) {
      return false;
    }
  }
  return true;
  } //check Token

  Future<bool> getTokens(String username, String password) async{
    try {
      Response response = await _dio.post(
        '${ServerStrings.authServerUrl}token/',
        data: {'username': username, 'password': password},
        options: Options(
          contentType: 'application/json',
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {"Accept": "application/json"}
        )
      );

      if (ImpactService.checkToken(response.data['access']) &&
      ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> refreshTokens() async{
    String? refToken = await retrieveSavedToken(true);
    try {
      Response response = await _dio.post(
        '${ServerStrings.authServerUrl}refresh/',
        data: {'refresh': refToken},
        options: Options(
          contentType: 'application/json',
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {"Accept": "application/json"}
        )
      );

      if (ImpactService.checkToken(response.data['access']) &&
          ImpactService.checkToken(response.data['refresh'])) {
        prefs.impactRefreshToken = response.data['refresh'];
        prefs.impactAccessToken = response.data['access'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateBearer() async{
    if (!await checkSavedToken()) {
      await refreshTokens();
    }
    String? token = await prefs.impactAccessToken;
    if (token != null) {
      _dio.options.headers = {'Authorization' : 'Bearer $token'};
    }
  }

}

  
