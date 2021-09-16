import "package:flutter/material.dart";
import 'package:senfood/screens/signUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../universal_variables.dart';
import 'loginScreen.dart';
class Profil extends StatefulWidget {

  @override
  _ProfilState createState() => _ProfilState();
}
class _ProfilState extends State<Profil> {
  var photoprofil ;
  var nomprofil ;
  var roleprofil ;
  var emailprofil;
  var adressprofil ;
  var telprofil;
  getInfo()async{

    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      photoprofil=prefs.getString("img")!;
      nomprofil = prefs.getString("username")!;
      roleprofil = prefs.getString("role")!;
      emailprofil = prefs.getString("email")!;
      adressprofil = prefs.getString("adresse")!;
      telprofil= prefs.getString("tel")!;
    });

  }
  @override
  void initState() {
    getInfo();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
    SingleChildScrollView(
      child:
      Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.redAccent, Colors.pinkAccent]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          photoprofil != null? photoprofil:
                          "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        nomprofil != null? nomprofil:
                        "Inconnue",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: <Widget>[

                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "Profil",
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      roleprofil != null? roleprofil:
                                      "XXX",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.pinkAccent,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    emailprofil != null? emailprofil:
                    'xxx@gmail.com',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Adresse',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    adressprofil != null? adressprofil:
                    'XxXx',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    'Telephone',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    telprofil != null? telprofil:
                    '777777777',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ) );
  }
}