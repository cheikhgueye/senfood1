
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_cardgridview/custom_cardgridview.dart';
import 'package:flutter/material.dart';
import 'package:senfood/mdele/user_model.dart';
import 'package:senfood/screens/menu.dart';
import 'package:senfood/widgets/card.dart';
import 'package:senfood/widgets/drawer.dart';

class WelcomeClient extends  StatefulWidget {
  @override
  _WelcomeClientState createState() => _WelcomeClientState();
}
class _WelcomeClientState extends State<WelcomeClient> {
  List<UserModel>? resto;


  getResto() async {
    var restau;
    FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: "Restaurateur")
        .snapshots()
        .listen((data) => {
          print( UserModel().dataListFromSnapshot(data)),
        UserModel().dataListFromSnapshot(data).forEach((element) {
          setState(() {
            resto=UserModel().dataListFromSnapshot(data);
          });

        })



    }





      //  data.docs.forEach((doc) => print(doc["username"]))


    )


    ;
    setState(() {
      resto=restau;
    });
    print(resto);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResto();
  }
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
      appBar: AppBar(title: Text("Accueil"),),
      body: GridCard(cardLayout:
      [

   if(resto!=null)
        for (var r in resto!)
        InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (_) =>Menu(uid: r.uid,)
          ));
    },

    child:
        CustomCard(

          imgPath: r.img,
          name: r.adresse,
          price: r.username,
          isFavorite: false,
          added: false,

        ))
      ]
      )
    );
  }
}