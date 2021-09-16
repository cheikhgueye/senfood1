
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:senfood/mdele/commande.dart';
import 'package:senfood/mdele/item.dart';
import 'package:senfood/mdele/repas.dart';
import 'package:senfood/screens/addRepas.dart';
import 'package:senfood/screens/mesCommandes.dart';
import 'package:senfood/universal_variables.dart';
import 'package:senfood/utils/firebase_database_util.dart';
import 'package:senfood/widgets/drawer.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Menu extends StatefulWidget {
  final uid;
  Menu({Key? key, this.uid}) : super(key: key);

  @override
  _RepasListState createState() => _RepasListState();
}

class _RepasListState extends State<Menu>

    with FCMNotificationMixin, FCMNotificationClickMixin {
  FirebaseDatabaseUtil? databaseUtil;

  final String serverToken = 'your key here';
  var uid = "";
  var cat= "";
  bool vu=false;
  List <Item>? items=[];
  getID ()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid=prefs.getString("uid")!;
    });
  }
  saveCommande() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var existe=false;
    var id;
  //var x=  databaseUtil!.addCommande(c);

  await   databaseUtil!.getCommandes()!.get().then((value) => {
    if(value!.value!=null)

      value!.value.forEach((key,v)=>{

        if(widget.uid==v["idresto"] && v["iduser"]==uid){
          print("ok"),
          existe=true,
          id=key,

          setState(() {

          })
        }
      })

    });
    print(existe);

    if(existe==true){
      print("wtf");
      items!.forEach((e) {
        if(e.quantite!=0){
          Commander(e);
          prefs.remove(e.rid+e.userid);


        }

      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommandeS()),
      );


    } else{

      Commande c=Commande(uid, false, widget.uid);

      await  databaseUtil!.addCommande(c);
      print("oklm");
      await   databaseUtil!.getCommandes()!.get().then((value) => {

        value!.value.forEach((key,v)=>{

          if(widget.uid==v["idresto"] && v["iduser"]==uid){

            id=key,

            setState(() {

            })
          }
        })

      });
      print("mongui bah");

      print(id);
      items!.forEach((e) {
        if(e.quantite!=0){
          Commander(e);
          prefs.remove(e.rid+e.userid);


        }

      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CommandeS()),
      );


    }


  }

Commander(Item i) async {
    try {


         commanderCollection.doc(i.rid+i.userid).set({
            "userid":i.userid,
            "restid":i.rid,
            "etat":i.etat,
            "prix":i.prix,
            "categorie":i.categorie,
            "img":i.img,
            "nom":i.nom,
            "quantite":i.quantite




          });

       // Navigator.of(context).pop();





    } catch (err) {

      //  _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }
  getMenu() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();


    databaseUtil!.getRepas()!.get().then((value) => {

     value!.value.forEach((key,v)=>{

       if(widget.uid==v["uid"] && v["etat"]==false){
     setState(() {
         items!.add(Item("", key, uid,v["prix"],v["etat"] , v["img"], prefs.getInt(key+uid)!=null?prefs.getInt(key+uid):0, v["uid"],v["nom"],v["categorie"]));

     })
       }
     })

   });



  /*   FirebaseFirestore.instance
         .collection('commande')
         .where('restid', isEqualTo: widget.uid)
         .snapshots()
         .listen((data) =>{


           print(data.docs)
     });*/


  }

  int _counter = 0;
  bool _anchorToBottom = true;

  void _incrementCounter() async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    print(  prefs.getString("guinte_uid"));

    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:


          Container(
              height: MediaQuery.of(context).size.height/1.5,
              child:

              AddRepas()

          ),
        )



    );
  }
  @override
  void initState() {
    getID();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil!.initState();

    if (!kIsWeb) {
      FCMConfig.messaging.subscribeToTopic('1');


    }
    getMenu();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    databaseUtil!.dispose();
    // _bannerAd?.dispose();

  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Menu du jour "),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child:buildBody()
      ),
    floatingActionButton: InkWell(

      onTap: () async{
        await  saveCommande();

      },
      child: Container(
        
        padding: EdgeInsets.all(10),
        height: 50,

        width: 230,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Icon(Icons.shopping_cart_rounded,color: Colors.white),
            SizedBox(width: 10,),
            Text("Confirmer la commande",style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildBody() {

    return


      Column(
                  children: [

                     Container(
                      alignment: Alignment.center,
                      height: 50,

                      child:  ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            SizedBox(width: 12,),
                            InkWell(

                                onTap: (){
                                  setState(() {
                                    cat="";
                                  });
                                },
                                child:
                                SingleChildScrollView(
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.clear_all_outlined),
                                      Text('Tous',style: TextStyle(color: cat==""?Colors.black:Colors.grey),),
                                    ],
                                  ),
                                )),
                            SizedBox(width: 12,),
                            InkWell(

                                onTap: (){
                                  setState(() {
                                    cat="Repas";
                                  });
                                },
                                child:
                                SingleChildScrollView(
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.food_bank_outlined),
                                      Text('Repas',style: TextStyle(color: cat=="Repas"?Colors.black:Colors.grey),),
                                    ],
                                  ),
                                )),
                            SizedBox(width: 12,),
                            InkWell(

                                onTap: (){
                                  setState(() {
                                    cat="Diner";
                                  });
                                },
                                child:
                                SingleChildScrollView(
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.no_food_outlined),
                                      Text('Diner',style: TextStyle(color: cat=="Diner"?Colors.black:Colors.grey),),
                                    ],
                                  ),
                                )),
                            SizedBox(width: 12,),
                            InkWell(

                                onTap: (){
                                  setState(() {
                                    cat="Dessert";
                                  });
                                },
                                child:
                                SingleChildScrollView(
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.food_bank_sharp),
                                      Text('Dessert',style: TextStyle(color: cat=="Dessert"?Colors.black:Colors.grey),),
                                    ],
                                  ),
                                )),
                            SizedBox(width: 12,),
                            InkWell(

                                onTap: (){
                                  setState(() {
                                    cat="Boisson";
                                  });
                                },
                                child:
                                SingleChildScrollView(
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.local_drink),
                                      Text('Boisson',style: TextStyle(color: cat=="Boisson"?Colors.black:Colors.grey),),
                                    ],
                                  ),

                                )),
                            SizedBox(width: 12,),
                            InkWell(

                                onTap: (){
                                  setState(() {
                                    cat="Glace";
                                  });
                                },
                                child:
                                SingleChildScrollView(
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.icecream),
                                      Text('Glace',style: TextStyle(color: cat=="Glace"?Colors.black:Colors.grey),),
                                    ],
                                  ),

                                )),
                            SizedBox(width: 12,),
                            InkWell(

                                onTap: (){
                                  setState(() {
                                    cat="Gateau";
                                  });
                                },
                                child:
                                SingleChildScrollView(
                                  child:  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.cake),
                                      Text('Gateau',style: TextStyle(color: cat=="Gateau"?Colors.black:Colors.grey),),
                                    ],
                                  ),

                                ))
                            //More ite
                            //More items
                          ]
                      ),
                    ),


                    if(items!=null)


                        for (var i in items!)


                 if((i.categorie==cat || cat=="") && i.etat==false)
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        height: 100,


                        decoration: BoxDecoration(
                          border: Border(

                            bottom: BorderSide( //                    <--- top side
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          /*   boxShadow: [
       BoxShadow(color: Colors.black,offset: Offset(0,1),
           blurRadius: 1
       ),
     ],
     image: new DecorationImage(
         fit: BoxFit.fill,
         colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
         image:AssetImage("assets/cons.gif")
     ),*/
                          color: Colors.white,
                          ///   borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child:  Stack(children: [
                          Container(
                            margin:EdgeInsets.only(left: 96 , ),

                            child:

                            ListTile(
                              onTap: (){


                              },
                              trailing:


                              //  Image.memory( Uint8List.fromList(Pv.fromSnapshot(snapshot).signA.codeUnits)),

                            Container(
                              width: 100,
                                  child:  Row(
                                    children: [
                                      InkWell(
                                        child:   Icon(Icons.remove),
                                        onTap: () async{
                                          SharedPreferences prefs=await SharedPreferences.getInstance();

                                          setState(() {
                                            i.quantites=i.quantite! >0?i.quantite! - 1:0;
                                          });

                                          if(i.quantite ==0){
                                            prefs.remove(i.rid+uid);


                                            print('ohh my good');
                                          } else {

                                            prefs.setInt(i.rid, i.quantite!);

                                            print(i.quantite);
                                          }

                                        },

                                      ),

                                      SizedBox(width: 10,),
                                 Text(i.quantite.toString()),
                                      SizedBox(width: 10,),
                                 InkWell(
                                   child:   Icon(Icons.add),
                                   onTap: () async{
                                     SharedPreferences prefs=await SharedPreferences.getInstance();

                                     setState(() {
                                       i.quantites=i.quantite! + 1;
                                     });
                                     if(i.quantite ==0){

                                       print('ohh my good');
                                     } else {

                                       prefs.setInt(i.rid+uid, i.quantite!);

                                     //  Commander( i);
                                       print(i.quantite);
                                     }
                                   },

                                 )


                                    ],
                                  )
                                ),








                              title: Text( i.nom!,style: TextStyle(fontWeight: FontWeight.bold),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  SizedBox(height: 15,),
                                  Text(i.prix!.toString()),
                                  SizedBox(height: 15,),
                               //   Text(Repas.fromSnapshot(snapshot).quantite!.toString()),
                                ],
                              ),

                            ),

                          ),
                          Positioned(
                            top: 6,
                            bottom: 6,
                            left: 5,
                            child: Container(
                              width: 90,
                              height: 80,

                              decoration: BoxDecoration(

                                /* boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,0),
                    blurRadius: 10
                ),
              ],*/
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                  image:NetworkImage(i.img!),

                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(80)),
                              ),
                            ),)
                        ],
                        ),
                      ),


                      //showUser(snapshot),


                      actions: <Widget>[



                      ],
                      secondaryActions: <Widget>[


                      ],
                    )



                  ],

                );


          //  :




          //; Container();




  }
  void send() async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'id': '1',
            'status': 'done',
          },
          'to': await FirebaseMessaging.instance.getToken(),
        },
      ),
    );
  }

  @override
  void onNotify(RemoteMessage notification) {
    // _firebaseMessagingBackgroundHandler(notification);
    setState(() {
      // _notification = notification;
    });
  }

  @override
  void onClick(RemoteMessage notification) {
    setState(() {
      //   _notification = notification;
    });
    print(
        'Notification clicked with title: ${notification.notification?.title} && body: ${notification.notification?.body}');
  }


}
