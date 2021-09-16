/*import 'dart:io';
import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'package:senfood/utils/hexa.dart';

import '../universal_variables.dart';

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {



// It needs a specific region, it will search in unite states.

  TextEditingController _categorieController = TextEditingController();
  TextEditingController _photoController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prixController = TextEditingController();
  TextEditingController   _quantiteController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    //  key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/pizza.jpg",)
              ),
              // color: Colors.black
              /*  gradient: LinearGradient(
               colors: GradientColors.blue,
             ),*/
            ),
            child: Center(
              child: Text(
                "",
                style: montserratStyle(45, Colors.white),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                /* image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/unnamed.gif",)
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
                //   color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child:
              SingleChildScrollView(
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide( //                    <--- top side
                                color: Colors.white,
                                width: 1.0,
                              ),
                              // borderRadius: BorderRadius.circular(10),
                              //color: Colors.transparent
                            )),
                        width: MediaQuery.of(context).size.width / 1.3,

                        //   padding: const EdgeInsets.only(left:10.0,right: 10),

                        child:

                        DropdownButton<String>(
                            isExpanded: true,
                            dropdownColor: Colors.white,

                       //     value:_categorie ,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),


                            items: <String>[
                              'Entrée',
                              'Salade',
                              'Dessert'

                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(

                                  value: value,
                                  child: ListTile (
                                    // leading: Icon(Icons.account_balance),
                                      title:
                                      Row (
                                        children: [
                                          Icon(Icons.account_balance,color: Colors.white),
                                          SizedBox(width: 10,),
                                          Container (

                                            child: Text(value,style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),

                                          )
                                        ],
                                      )
                                  )

                              );
                            }).toList(),
                            hint: ListTile(
                              //  leading: Icon(Icons.account_balance),
                                title: Row (
                                  children: [
                                    Icon(Icons.account_balance,color: Colors.white),
                                    SizedBox(width: 10,),
                                    Container (

                                      child: Text("Categorie de menu",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                                    )
                                  ],
                                )

                            ),
                            onChanged: (String? value) {
                              setState(() {
                            //    _categorie=value!;
                           //     _categorieController.text=value;
                              });
                            }

                        ),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                     /*   onTap: () async{
                          var url=  await upload();
                          setState(() {
                            _photoController.text=url;
                          });

                          print(url);
                        },*/
                        child:
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide( //                    <--- top side
                                      color: Colors.white,
                                      width: 1.0,
                                    )
                                  // borderRadius: BorderRadius.circular(10),
                                  //color: Colors.transparent
                                )),
                            // height: 20,
                            width: MediaQuery.of(context).size.width / 1.3,

                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                _photoController.text=="" ?    Icon(Icons.add_photo_alternate_outlined,color: Colors.white):
                                Container(
                                    margin: EdgeInsets.only(bottom: 15),
                                    alignment: Alignment.centerLeft,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white ,
                                        image: DecorationImage(image: NetworkImage(_photoController.text))
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  _photoController.text=="" ?    "Ajouter une photo": "Modifier la photo",

                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:Colors.white,
                                  ),
                                ),

                              ],
                            )
                        ),
                      ),

                      SizedBox(height:20,),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent
                        ),
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: _nomController,
                          style: montserratStyle(18, Colors.white),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            hintText: "Nom du repas",
                            prefixIcon: Icon(Icons.person,color: Colors.white),
                            //   hintStyle: TextStyle(color: Colors.white),

                            hintStyle: ralewayStyle(
                              20,
                              Colors.white,
                            ),
                          ),
                          keyboardType: TextInputType.text,

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent
                        ),
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: _prixController,
                          style: montserratStyle(18, Colors.white),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            hintText: "Prix du repas",
                            prefixIcon: Icon(Icons.person,color: Colors.white),
                            //   hintStyle: TextStyle(color: Colors.white),

                            hintStyle: ralewayStyle(
                              20,
                              Colors.white,
                            ),
                          ),
                          keyboardType: TextInputType.number,

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent
                        ),
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: _quantiteController,
                          style: montserratStyle(18, Colors.white),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            hintText: "Quantite",
                            prefixIcon: Icon(Icons.person,color: Colors.white),
                            //   hintStyle: TextStyle(color: Colors.white),

                            hintStyle: ralewayStyle(
                              20,
                              Colors.white,
                            ),
                          ),
                          keyboardType: TextInputType.number,

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),


                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent
                        ),
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: TextField(
                          controller: _descriptionController,
                          style: montserratStyle(18, Colors.white),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            hintText: "Description",
                            prefixIcon: Icon(Icons.person,color: Colors.white),
                            //   hintStyle: TextStyle(color: Colors.white),

                            hintStyle: ralewayStyle(
                              20,
                              Colors.white,
                            ),
                          ),
                          keyboardType: TextInputType.multiline,

                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),



                      InkWell(
                        onTap: signUpUser,
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
                              "Ajouter le repas",
                              style: ralewayStyle(20, HexColor('#FF7600')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
*/