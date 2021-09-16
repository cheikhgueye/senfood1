
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFood extends StatefulWidget {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:  EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Form(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget> [
                Image.asset('assets/logo.png',height: 100, width: 100),
                Center(
                  child: Text('Ajout de repas',
                  style: Theme.of(context).textTheme.title),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name ',
                    border:   OutlineInputBorder()
                  )
                ),
                SizedBox(height: 10),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Price ',
                        border:   OutlineInputBorder()
                    )
                ),
                FlatButton(
                  onPressed: () async{
                   // SharedPreferences prefs = await SharedPreferences.getInstance();
                    //prefs.setString('xxx', controller.text);
                     print(controller.text);

                  } ,





                  color: Colors.yellow,
                  child: Text('Save'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
   }