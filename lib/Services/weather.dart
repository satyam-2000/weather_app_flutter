


import 'package:clima/Services/location.dart';
import 'package:clima/Services/networking.dart';





class WeatherModel {

  static const apiKey='a17c4f884b3fbe8847c1fc512567c771';
  static const openUrl='https://api.openweathermap.org/data/2.5/weather';

  Future<dynamic> getWeatherUsingCity(String cityName) async{
    var url='$openUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper=NetworkHelper(url);
    var data=await networkHelper.getData();
    return data;
  }


  Future<dynamic> getWeatherData() async{
    Location location=Location();
    await location.getCurrentLocation();
    var latiTude=location.latitude;
    var longiTude=location.longitude;








    NetworkHelper networkHelper=NetworkHelper('$openUrl?lat=$latiTude&lon=$longiTude&appid=$apiKey&units=metric');
    var data=await networkHelper.getData();

    return data;
  }



  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
