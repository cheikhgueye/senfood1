
import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
///import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:loading_indicator/loading_indicator.dart';


import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:senfood/mdele/repas.dart';
import 'package:senfood/utils/firebase_database_util.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as path;
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AddRepas  extends  StatefulWidget {


  const AddRepas  ({Key? key,});
  @override
  _AddRepasState createState() => _AddRepasState();
}

class _AddRepasState extends State< AddRepas   > {
  FirebaseDatabaseUtil? databaseUtil;
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'SN';
  PhoneNumber number = PhoneNumber(isoCode: 'SN');
  static GlobalKey previewContainer = new GlobalKey();
  static const androidMethodChannel = const MethodChannel('team.native.io/screenshot');


  Uint8List? _imageFile;

  bool _anchorToBottom = true;
  List<String> attachments = [];
  List<String> imgs = ["","","","","",""];
  bool isHTML = false ;

  final _recipientController = TextEditingController(
    text: 'A@gmail.com',
  );

  final _subjectController = TextEditingController(text: "E-constat");
  final _dateController = TextEditingController(text: "");
  final _heureController = TextEditingController(text: "");
  final _lieuController = TextEditingController(text: "");
  final _prixController = TextEditingController(text: "");
  final _descriptionController = TextEditingController(text: "");
  final _quantiteController = TextEditingController(text: "");
  final _imageController = TextEditingController(text: "");
  final _videoController = TextEditingController(text: "");
  final _latController = TextEditingController(text: "");
  final _longController = TextEditingController(text: "");



  final _bodyController = TextEditingController(
    text: 'E-constat',
  );


  String role="";
  String cat="";
var  _cat=null;
  final nom = TextEditingController();
  var     loader=false;


  String _placeName = 'Unknown';





  @override
  void initState() {
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil!.initState();
    super.initState();



  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();

    databaseUtil!.dispose();

  }


  add() async {
    SharedPreferences prefs =await SharedPreferences.getInstance();
/*

    String? _nom;
    int? _prix ;
    String? _description;
    String? _categorie;
    String? _img;
    String? _quantite;
    //user added
    bool? _etat;*/

    Repas body=Repas("",nom.text,int.tryParse(_prixController.text),false,_descriptionController.text,cat,_imageController.text,int.tryParse(_quantiteController.text),prefs.getString("uid"),

    );
    databaseUtil!.addRepas(body);

  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }
  Widget getTextField(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(

        keyboardType:inputBoxName=="Prix" || inputBoxName=="Quantite"?  TextInputType.number:null,


        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }
  Widget getTextFieldp(
      String inputBoxName, TextEditingController inputBoxController) {
    var loginBtn = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new TextFormField(
        obscureText: true,
        keyboardType:inputBoxName=="N° Tél :"?  TextInputType.number:null,


        controller: inputBoxController,
        decoration: new InputDecoration(
          hintText: inputBoxName,
        ),
      ),
    );

    return loginBtn;
  }

  upload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File file=File("");

    if(result != null) {
      file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }

    var now=new DateTime.now();
    var reference = FirebaseStorage.instance.ref().child("repas"+now.toString());
    await reference.putFile(file);
    var url = await reference.getDownloadURL();
    return url;




    /*  String fileName = basename(_imageFile.path);
   StorageReference firebaseStorageRef =
   FirebaseStorage.instance.ref().child('uploads/$fileName');
   StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
   StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
   taskSnapshot.ref.getDownloadURL().then(
         (value) => print("Done: $value"),
   );*/



  }
  @override
  Widget build(BuildContext context) {
    return
      /*  Screenshot(
       controller: screenshotController,
       child:*/
      Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body:
          SingleChildScrollView(
            child:
            new
            Container(
                height: MediaQuery.of(context).size.height-70,
                child:
                Stack(




                  children: [


                    Positioned(


                        top: 0,
                        right: 0,




                        child:

                        Center(
                            child:
                            FlatButton(
                              onPressed: () => {
                                Navigator.of(context).pop()

                              },
                              color: Colors.transparent,
                              padding: EdgeInsets.all(5.0),
                              minWidth: 10,



                              child:
                              Icon(Icons.clear,color: Colors.black,),
                            )




                        )),
                    Positioned(


                        top: 45,
                        right: 0,
                        left: 0,




                        child:

                        Center(
                            child:Text("Ajouter un repas",
                              style: TextStyle(fontSize: 20),)




                        )),


                    Container(
                      margin: EdgeInsets.only(top: 90),




                      child:

                      SingleChildScrollView(
                        child:

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,


                          children: [

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

                                  value:_cat ,
                                  //elevation: 5,
                                  style: TextStyle(color: Colors.black),


                                  items: <String>[

                                    'Repas',
                                    'Diner',
                                    'Dessert',
                                    'Boisson',
                                    'Glace',
                                    'Gateau'

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
                                          Icon(Icons.fastfood_outlined,color: Colors.grey),
                                          SizedBox(width: 10,),
                                          Container (

                                            child: Text("Categorie",style: TextStyle(fontSize: 20,color: Colors.grey,fontWeight: FontWeight.bold),),

                                          )
                                        ],
                                      )

                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      cat=value!;

                                    });
                                  }

                              ),

                            ),

                            SizedBox(height: 10 ,),
                            getTextField("Nom",nom),
                            SizedBox(height: 10,),

                            getTextField("Prix",_prixController),
                            SizedBox(height: 10,),

                            getTextField("Quantite",_quantiteController),
                            SizedBox(height: 10,),

                            InkWell(
                              onTap: () async{
                                var url=  await upload();
                                setState(() {
                                  _imageController.text=url;
                                });

                                print(url);
                              },
                              child:
                              Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide( //                    <--- top side
                                            color: Colors.black,
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
                                      _imageController.text=="" ?   Icon(Icons.add_photo_alternate_outlined,color: Colors.black):
                                      Container(
                                          margin: EdgeInsets.only(bottom: 15),
                                          alignment: Alignment.centerLeft,
                                          width: 20,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.black ,
                                              image: DecorationImage(image: NetworkImage(_imageController.text))
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        _imageController.text=="" ?    "Ajouter une photo": "Modifier la photo",

                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color:Colors.black,
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                            ),
                            SizedBox(height: 10,),

                            getTextField("Description",_descriptionController),
                            SizedBox(height: 10,),

                            SizedBox(height: 30,),
                            Container(
                              height:
                              40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color:Theme.of(context).primaryColor,),
                              child:
                              loader==true?Container(
                                  alignment: Alignment.center,
                                  child:LoadingIndicator(indicatorType: Indicator.circleStrokeSpin,)
                              ):




                              FlatButton(
                                child: Text(
                                  "Ajouter",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                    15,


                                  ),
                                ),
                                onPressed: () async {


                                  if( nom.text!=""){
                                    await add();
                                    Navigator.of(context).pop();

                                  }





                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )




                  ],
                )

            ),


          ));

  }

}
