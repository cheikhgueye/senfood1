import 'package:flutter/material.dart';
import 'package:senfood/widgets/drawer.dart';

class WelcomeLivreur extends  StatefulWidget {
  @override
  _WelcomeLivreurState createState() => _WelcomeLivreurState();
}
class _WelcomeLivreurState extends State<WelcomeLivreur> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
      Container(

        width: 250,

        child:Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
            child: MyDrawer()
        ),),
      appBar: AppBar(),
        body: Center(
          child: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.yellow,
            activeColor: Colors.orangeAccent,
          ),
        )
    );
  }
}