import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/Services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/Services/networking.dart';
import 'package:clima/Screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'error_screen.dart';
import 'package:clima/Services/weather.dart';

const apiKey='a17c4f884b3fbe8847c1fc512567c771';

class LoadingScreen extends StatefulWidget {


  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  WeatherModel weatherModel=WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openLocationOrError();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  ///
  ///

  void openLocationOrError() async {

   var data= await weatherModel.getWeatherData();

   print('data is $data');


   

     Navigator.push(context, MaterialPageRoute(builder: (context){

       return LocationScreen(data);



     }));


  }





    @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Container(margin: EdgeInsets.only(bottom: 60.0)
              ,child: Text('CLIMA APP',textAlign: TextAlign.center,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60.0,
                fontFamily:'Dosis',
                color: Colors.red
              ),)),),
          Center(
            child: SpinKitWave(
              color: Colors.red,
              size: 100.0,
            ),
          ),
          Container(child: Text('Getting Location. Make Sure Location Should be on. '
          ,style: TextStyle(color: Colors.red,fontSize: 15.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),margin: EdgeInsets.only(top: 30.0),)
        ],
      ),
    );
  }
}
