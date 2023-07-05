
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

  static String userID = '<YOUR_ID>';
  static String name = '<YOUR_NAME>';
}