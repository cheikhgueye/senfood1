import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthPage> {
var number ;
 getNumber() async {

   SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     number = prefs.getString('numero');
   });
 }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Center(
        child:
        Text ('Le numero est le : ' + number , style: TextStyle(color:number=="776585821"?Colors.green:Colors.yellow), )
      ),
    );
  }
}