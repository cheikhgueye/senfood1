import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Api {
  Future<dynamic> notify(body) async {

    SharedPreferences prefs =await SharedPreferences.getInstance();
    var token  = prefs.getString("token");


    final http.Response response = await http.Client().post(
      Uri.parse("https://fcm.googleapis.com/fcm/send") ,
        body: json.encode(body),
    headers: {
    'Content-Type': 'application/json',
    //'Accept': 'application/json',
    'Authorization': "key=AAAA3wPuYMo:APA91bFM0aGtbvy9CT7MSVjtJk0xr9ASw4a3BBkzYGxlIz_gLgGb2MiCpu-pX8R7265SVYg1QqsVTsrx6-C03FEzEnqNhTZCU9HQDwahXwNpqZcGz0a0GpZAi5D8B9-0vHwrpQQtHgmN"
    },
    );
    print(response.body );
    if (response.statusCode >= 400) {

    return "err";
    throw ('An error occurred: ' + response.body);
    }
  } }