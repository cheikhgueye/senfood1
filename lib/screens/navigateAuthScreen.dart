import "package:flutter/material.dart";
import 'package:senfood/screens/addRepas.dart';
import 'package:senfood/screens/repasList.dart';
import 'package:senfood/screens/signUpScreen.dart';
import 'package:senfood/screens/welcomeClient.dart';
import 'package:senfood/screens/welcomeLivreur.dart';
import 'package:senfood/screens/welcomeRestaurateur.dart';
import 'package:senfood/service/api.dart';
import 'package:senfood/utils/hexa.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../universal_variables.dart';
import 'loginScreen.dart';
class NavigateAuthScreen extends StatefulWidget {
  @override
  _NavigateAuthScreenState createState() => _NavigateAuthScreenState();
}
class _NavigateAuthScreenState extends State<NavigateAuthScreen> {
  redirect () async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    if (prefs.getString("uid")!= null)
      {

     prefs.getString("role") =='Livreur'?
    Navigator.push(context, MaterialPageRoute(
    builder: (_) =>WelcomeLivreur()
    )): prefs.getString("role") =='Restaurateur'?
    Navigator.push(context, MaterialPageRoute(
    builder: (_) =>RepasList()
    )):Navigator.push(context, MaterialPageRoute(
    builder: (_) =>WelcomeClient()
    ));
      }
  }

   notification ()async {
    var body = {
      "to": "/topics/Aicha",
      "notification" : {
        "body" : "New event",
        "content_available" :"1",
        "priority" : "high",
        "title" : "Event"
      },
      "data" : {
        "body" : "Détails event",
        "content_available" :"1",
        "priority" : "high",
        "title" : "Event1"
      }
    };

    await Api().notify(body);

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  notification();
    redirect();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
           // height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/san.jpg",)
                ),
                //color:Colors.black
              /*   gradient: LinearGradient(
               colors: GradientColors.blue,
             ),*/
            ),

          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(

              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.6,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
              /* image: DecorationImage(
                    fit: BoxFit.fill,
                   // image: AssetImage("assets/unnamed.gif",)
                ),*/
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => LoginScreen())),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 5),


                        //    gradient: LinearGradient(colors: GradientColors.blue),
                        borderRadius: BorderRadius.circular(20),
                        //  color: Color(0xFFff69b4)
                      ),
                      child: Center(
                        child: Text(
                          "Se connecter",
                          style: ralewayStyle(20, HexColor('#FF7600')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height:40,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => SignUpScreen())),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 5),
                        //  gradient: LinearGradient(colors: GradientColors.pink),
                        borderRadius: BorderRadius.circular(20),
                        //   color:Colors.pinkAccent.withOpacity(5.0)
                      ),
                      child: Center(
                        child: Text(
                          "S'inscrire",
                          style: ralewayStyle(20, HexColor('#FF7600')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height:40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
