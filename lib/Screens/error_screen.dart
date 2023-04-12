import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {

  var textData;
  ErrorScreen(this.textData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      color: Colors.red,

      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.error,size: 90.0,),),
          Center(child: Text('$textData',style: TextStyle(fontSize: 20.0),),),
        ],
      ) ,
    ),);
  }
}
