import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  String url;
  NetworkHelper(this.url);

  Future<String> getData() async{


      http.Response response= await http.get(Uri.parse(url));
      print('Status code is ${response.statusCode}');
      if(response.statusCode==200){
        String data=response.body;

        return data;
      }

      else{
        return 'error';
      }








  }
}