import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senfood/mdele/user_model.dart';
import 'package:senfood/screens/repasList.dart';
import 'package:senfood/screens/welcomeClient.dart';
import 'package:senfood/screens/welcomeLivreur.dart';
import 'package:senfood/screens/welcomeRestaurateur.dart';
import 'package:senfood/utils/hexa.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../universal_variables.dart';
import 'profil.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  loginUser() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();

    try {
      int ctr = 0;
      var data   = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);




      FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: data.user!.uid)
          .snapshots()
          .listen((data) =>{

        print(UserModel().dataListFromSnapshot(data)[0].username),
        prefs.setString("username", UserModel().dataListFromSnapshot(data)[0].username!),
        prefs.setString("adresse", UserModel().dataListFromSnapshot(data)[0].adresse!),
        prefs.setString("img", UserModel().dataListFromSnapshot(data)[0].img!),
        prefs.setString("date", UserModel().dataListFromSnapshot(data)[0].date!),
        prefs.setString("uid", UserModel().dataListFromSnapshot(data)[0].uid!),
        prefs.setString("role", UserModel().dataListFromSnapshot(data)[0].role!),
        prefs.setString("tel", UserModel().dataListFromSnapshot(data)[0].tel!),
        prefs.setString("email", UserModel().dataListFromSnapshot(data)[0].email!),
        print (UserModel().dataListFromSnapshot(data)[0].username!),
        UserModel().dataListFromSnapshot(data)[0].role! =='Livreur'?
        Navigator.push(context, MaterialPageRoute(
            builder: (_) =>WelcomeLivreur()
        )):UserModel().dataListFromSnapshot(data)[0].role! =='Restaurateur'?
        Navigator.push(context, MaterialPageRoute(
            builder: (_) =>RepasList()
        )):Navigator.push(context, MaterialPageRoute(
            builder: (_) =>WelcomeClient()
        ))






       /* Navigator.push(context, MaterialPageRoute(
            builder: (_) =>FeedScreen()
        ))*/
      }



        //  data.docs.forEach((doc) => print(doc["username"]))


      )


      ;





      /*  Navigator.of(context).popUntil((route){
       return ctr++ == 2;
     });*/
      Navigator.of(context).pop();
    } catch (err) {
      print( err.toString().substring(30));
      var snackBar = SnackBar(
        content: Text(
          err.toString().substring(30),

        ),
      );
      _scaffoldKey.currentState!.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.black,
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
         //   height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/pizza.jpg",)
                ),
              //  color:Colors.black
              /* gradient: LinearGradient(
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

              //  image: DecorationImage(
               //     fit: BoxFit.fill,
                  //  image: AssetImage("assets/unnamed.gif",)
               // ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                       // color: Colors.white
                    ),
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: _emailController,
                      style: montserratStyle(14, Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.email,color: Colors.white),
                       border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),

                    //    color: Colors.white
                    ),
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: TextField(
                      controller: _passwordController,
                      style: montserratStyle(14, Colors.white),
                      decoration: InputDecoration(
                        hintText: "Mot de passe",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.lock,color: Colors.white),
                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),

                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: loginUser,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
