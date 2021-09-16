
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senfood/screens/addMenu.dart';
import 'package:senfood/screens/mesCommandes.dart';
import 'package:senfood/screens/profil.dart';
import 'package:senfood/screens/navigateAuthScreen.dart';
import 'package:senfood/screens/repasList.dart';
import 'package:senfood/screens/restCommande.dart';
import 'package:senfood/screens/welcomeClient.dart';
import 'package:senfood/utils/hexa.dart';
import 'package:shared_preferences/shared_preferences.dart';
class  MyDrawer extends  StatefulWidget {
  @override
  _WelcomeLivreurState createState() => _WelcomeLivreurState();
}
class _WelcomeLivreurState extends State<MyDrawer> {
  var role ="";




  Container _buildDivider() {
    return Container(

      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: 250,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
  redirect () async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      role=prefs.getString("role")!;
    });

  }
@override
  void initState() {
  redirect ();
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(

      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[

               Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,


              ])
      ),
      child:  ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(

            child:   Container(
              //  margin: EdgeInsets.only(left: 650),
              alignment: Alignment.center,
              //  height: 50,
              //  width:90,
              child: Image.asset(
                  'assets/logo.jpg',
                  //  height: double.infinity,
                  //  width: double.infinity,
                  fit: BoxFit.contain
              ),
            ),
            decoration: BoxDecoration(

              color: Colors.transparent,

            ),
          ),

          SizedBox(height: 20,),
          new InkWell(
              onTap: () => {
                print("ok"),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>


                  role=='Restaurateur'?RepasList() :    WelcomeClient()


                  ),
                )
              },
              child:
              Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.reorder,color: Colors.redAccent,),
                  SizedBox(width: 8,),
                  Text('Accueil',style:GoogleFonts.lato(
                    textStyle:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.redAccent),
                  ),




                  ),
                ],
              )),
          SizedBox(height: 20,),
          _buildDivider(),
          SizedBox(height: 20,),

          new InkWell(
              onTap: () => {
                print("ok"),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>role=='Restaurateur'?CommandeR() :  CommandeS()),
                )
              },
              child:
              Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.reorder,color: Colors.redAccent,),
                  SizedBox(width: 8,),
                  Text('Mes commandes',style:GoogleFonts.lato(
                    textStyle:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.redAccent),
                  ),




                  ),
                ],
              )),


           SizedBox(height: 20,),
         _buildDivider(),
         SizedBox(height: 20,),
          new InkWell(
              onTap: () => {
                print("ok"),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profil()),
                )
              },
              child:
              Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.person_outline,color: Colors.redAccent,),
                  SizedBox(width: 8,),
                  Text('Profil',style:GoogleFonts.lato(
                    textStyle:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.redAccent),
                  ),




                  ),
                ],
              )),
          SizedBox(height: 20,),
          _buildDivider(),
          SizedBox(height: 20,),
          new InkWell(
              onTap:  () async{
                SharedPreferences prefs=await SharedPreferences.getInstance();
                prefs.remove("uid");

                print("ok");
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => NavigateAuthScreen()
                ));

                /*   Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => Login()),
                         )*/
              },
              child:
              Row(
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.power_settings_new_outlined,color: Colors.redAccent,),
                  SizedBox(width: 8,),

                  Text('Deconnexion' ,style:GoogleFonts.lato(
                    textStyle:  TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.redAccent),
                  ),



                  ),
                ],
              )),

        ],
      ),
    );

  }
}

