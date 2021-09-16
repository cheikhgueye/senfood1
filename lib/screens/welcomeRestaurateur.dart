import 'package:flutter/material.dart';
import 'package:senfood/widgets/drawer.dart';

class WelcomeRestaurateur extends  StatefulWidget {
  @override
  _WelcomeRestaurateurState createState() => _WelcomeRestaurateurState();
}
class _WelcomeRestaurateurState extends State<WelcomeRestaurateur> {
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
        child: RaisedButton(
          child: Text('Ajout',style: TextStyle(color: Colors.white),),
          color: Colors.pink,
          onPressed: () => _displayDialog(context),
        ),
      ),
    );

  }
  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Ajouter un menu"),
            ),

            actions: <Widget>[
              new FlatButton(
                child: new Text('Ajouter'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )

            ],



          );
        });
  }
}
