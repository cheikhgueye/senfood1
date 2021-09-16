import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_cardgridview/custom_cardgridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:senfood/mdele/commande_model.dart';
import 'package:senfood/mdele/user_model.dart';
import 'package:senfood/screens/menu.dart';
import 'package:senfood/widgets/card.dart';
import 'package:senfood/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends  StatefulWidget {
  final idresto;

  const Detail({Key? key, this.idresto}) : super(key: key);
  @override
  _DetailState createState() => _DetailState();
}
class _DetailState extends State<Detail> {
  List<CommandeModel>? resto;
  int total=0;
  var uid="";
  getID ()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid=prefs.getString("uid")!;
    });
  }


  getDetail() async {
   await getID();
    var restau;
  await   FirebaseFirestore.instance
        .collection('commande')
        .where('userid', isEqualTo: uid)
        .snapshots()
        .listen((data) => {
      print( CommandeModel().dataListFromSnapshot(data)),
      CommandeModel().dataListFromSnapshot(data).forEach((element) {
        setState(() {
          resto=CommandeModel().dataListFromSnapshot(data);
        });
        resto!.forEach((p) {
          setState(() {
            total=total+(p.prix! * p.quantite!);
          });

        });



      })



    }





      //  data.docs.forEach((doc) => print(doc["username"]))


    )


    ;
  print(resto!.length);


  }


  @override
  void initState() {
    getDetail();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("Détails de la commande"),
        ),
        body: Column(children: [


   if(resto!=null)
          for (var r in resto!)

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
                    margin:EdgeInsets.only(left: 146 , ),

                    child:

                    ListTile(
                      onTap: (){


                      },
                  trailing:Text("x "+r.quantite.toString()),


                      //  Image.memory( Uint8List.fromList(Pv.fromSnapshot(snapshot).signA.codeUnits)),

                   /*   Icon(Icons.check_box,color:    Commande.fromSnapshot(snapshot).etat==false?Colors.green:Colors.red,),*/




                      title: Text(r.nom!,style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(height: 15,),
                          Text(r.prix.toString()),
                          SizedBox(height: 15,),
                          Text(" "),
                        ],
                      ),

                    ),

                  ),
                  Positioned(
                    top: 6,
                    bottom: 6,
                    left: 5,
                    child: Container(
                      width: 150,
                      height: 90,

                      decoration: BoxDecoration(

                        /* boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,0),
                    blurRadius: 10
                ),
              ],*/
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          // colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                          image:NetworkImage(r.img!),

                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),)
                ],
                ),
              ),


              //showUser(snapshot),


              actions: <Widget>[
                /*    Repas.fromSnapshot(snapshot).etat==false?

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
                        )*/





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



              ],
              secondaryActions: <Widget>[


                /*   IconSlideAction(

                          caption: 'Supprimer',
                          color: Colors.red.shade500,
                          icon: Icons.delete,
                          onTap: () =>{

                            databaseUtil!.delete(Repas.fromSnapshot(snapshot))
                          },
                        ),*/

              ],
            ),
          SizedBox(height: 15,),

          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Total prix :"),
                SizedBox(width: 10,),
                Text(total.toString()+"CFA"),
              ],
            )
          )

        ]
        )
    );
  }
}