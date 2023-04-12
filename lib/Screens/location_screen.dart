import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/Services/weather.dart';
import 'dart:convert';
import 'package:clima/Services/networking.dart';
import 'package:clima/Screens/error_screen.dart';
import 'package:clima/Screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel=WeatherModel();
  late int temperature;
  late String weatherCondition;
  late String cityName;
  late String message;



   void updateUI(dynamic weatherData) {



     setState(() {

       if(weatherData==null){
         temperature=0;
         message='Error Occured';
         cityName='';
         return;
       }


       double temp=jsonDecode(weatherData)['main']['temp'];
       temperature=temp.toInt();
       message=weatherModel.getMessage(temperature);
       var cod=jsonDecode(weatherData)['weather'][0]['id'];
       weatherCondition=weatherModel.getWeatherIcon(cod);
       cityName=jsonDecode(weatherData)['name'];

     });




  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      updateUI(widget.weatherData);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Colors.blue.shade300,
                Colors.blue.shade400,
                Colors.indigo.shade400,
                Colors.indigo.shade500,
              ],
            )
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData=await weatherModel.getWeatherData();
                      setState(() {
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(Icons.refresh_sharp,color: Colors.white,size: 40.0,)
                  ),
                  FlatButton(
                    onPressed: () async{
                      var typedNAme=await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },),);

                      var weatherData= await weatherModel.getWeatherUsingCity(typedNAme);
                      if(weatherData=='error'){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ErrorScreen('Invalid City Name');
                        }));
                      }
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherCondition',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Text(

                  '$message in $cityName',
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
