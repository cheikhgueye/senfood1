
import 'dart:convert';
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
import 'package:senfood/mdele/repas.dart';
import 'package:senfood/screens/addRepas.dart';
import 'package:senfood/utils/firebase_database_util.dart';
import 'package:senfood/widgets/drawer.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class RepasList extends StatefulWidget {
  RepasList({Key? key}) : super(key: key);

  @override
  _RepasListState createState() => _RepasListState();
}

class _RepasListState extends State<RepasList>

    with FCMNotificationMixin, FCMNotificationClickMixin {


  final String serverToken = 'your key here';
  var uid = "";
  var cat= "";
   getID ()async{

     SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       uid=prefs.getString("uid")!;
     });
   }

  int _counter = 0;
  bool _anchorToBottom = true;
  FirebaseDatabaseUtil? databaseUtil;

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
      drawer:
      Container(

        width: 250,

        child:Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
            child: MyDrawer()
        ),),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Liste repas"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child:buildBody()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Payer',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildBody() {

    return

      new FirebaseAnimatedList(
        key: new ValueKey<bool>(_anchorToBottom),
        query: databaseUtil!.getRepas()!,

        reverse: !_anchorToBottom,
        sort: _anchorToBottom
            ? (DataSnapshot a, DataSnapshot b) => b.key!.compareTo(a.key!)
            : null,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
        //  print(Repas.fromSnapshot(snapshot).id);

          return
            Repas.fromSnapshot(snapshot).uid!=uid?  SizedBox():
            new SizeTransition(
              sizeFactor: animation,
              child: Column(
                children: [

                  SizedBox(height: index==0?   20:1,),
                  index==0? Container(
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
                  ):SizedBox(),

                  index==0?    SizedBox(height: 20,):SizedBox(),
                  Repas.fromSnapshot(snapshot).categorie==cat || cat==""?

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

                          Icon(Icons.remove_red_eye_outlined,color:   Repas.fromSnapshot(snapshot).etat==false?Colors.green:Colors.red,),




                          title: Text( Repas.fromSnapshot(snapshot).nom!,style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              SizedBox(height: 15,),
                              Text(Repas.fromSnapshot(snapshot).prix!.toString()),
                              SizedBox(height: 15,),
                              Text(Repas.fromSnapshot(snapshot).quantite!.toString()),
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
                              image:NetworkImage(Repas.fromSnapshot(snapshot).img!),

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
                      Repas.fromSnapshot(snapshot).etat==false?

                      IconSlideAction(
                        caption: 'Archiver',
                        color: Colors.green,
                        icon: Icons.check,
                        onTap: () =>{

                          setState(() {
                            databaseUtil!.archiver(Repas.fromSnapshot(snapshot),true);
                          })
                        },
                      ):



                      IconSlideAction(
                          caption: 'Dearchiver',
                        color: Colors.deepOrange,
                        icon: Icons.check,
                        onTap: () =>{

                          setState(() {
                            databaseUtil!.archiver(Repas.fromSnapshot(snapshot),false);

                          }
                          )
                        },
                      )





                      /* IconSlideAction(
             caption: 'Refuser',
             color: Colors.blue,
             icon: Icons.radio_button_unchecked,
             onTap: () =>{

               setState(() {
               //  databaseUtil.desarchiver(Pv.fromSnapshot(snapshot),true);
               })
             },
           )*/

                      ,

                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(

                        caption: 'Supprimer',
                        color: Colors.red.shade500,
                        icon: Icons.delete,
                        onTap: () =>{

                        databaseUtil!.delete(Repas.fromSnapshot(snapshot))
                        },
                      ),

                    ],
                  ):SizedBox()



                ],

              ));


          //  :




          //; Container();
        },
      );



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
