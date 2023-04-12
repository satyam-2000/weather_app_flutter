import 'package:geolocator/geolocator.dart';

class Location{

  late double latitude;
   late double longitude;

  Future<void> getCurrentLocation() async {
    try{
      LocationPermission permission;
      permission = await Geolocator.checkPermission();




      Position position = await
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true,
          desiredAccuracy: LocationAccuracy.lowest);


      latitude=position.latitude;
      longitude=position.longitude;
    }

    catch(e){
      print('exception occured');
    }


  }



}