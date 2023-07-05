//import 'package:agri_fit/screens/profilePage.dart';


String checkBMI(calculatedBMI){
  if(calculatedBMI < 18.5){
    return 'Underweight';
    }
  else if(calculatedBMI >= 18.5 && calculatedBMI <= 24.9){
    return 'Normal weight';
  }
  else if(calculatedBMI >= 25.0 && calculatedBMI <= 29.9){
    return'Pre-obesity';
  }
  else if(calculatedBMI >= 30.0 && calculatedBMI <= 34.9){
    return 'Obesity class 1';
  }
  else if(calculatedBMI >= 35.0 && calculatedBMI <= 39.9){
    return 'Obesity class 2';
  }
  else{
    return 'Obesity class 3';
  }
}