import 'dart:io';
import 'dart:math';

import 'package:address_search_field/address_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:senfood/utils/hexa.dart';

import '../universal_variables.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final origCtrl = TextEditingController();

  final destCtrl = TextEditingController();



  final geoMethods = GeoMethods(
    googleApiKey: 'AIzaSyDCzy2TmzkKmW5fnHbWfzuCVE9IfU4VZY0',
    language: 'fr',
    countryCode: 'sn',
    countryCodes: ['sn', 'sn', 'sn'],
    country: 'Senegal',
    city: '',
  );

// It needs a specific region, it will search in unite states.

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController   datenaissancerpl = TextEditingController();
  TextEditingController _photoController = TextEditingController();

  TextEditingController _telController = TextEditingController();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'SN';
  PhoneNumber number = PhoneNumber(isoCode: 'SN');
  var  _role=null;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> results=[""];
  // generates a new Random object
  final _random = new Random();
  CollectionReference _fireStore = FirebaseFirestore.instance.collection('typefemme');

  upload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File file=File("");

    if(result != null) {
      file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }

    var now=new DateTime.now();
    var reference = FirebaseStorage.instance.ref().child("users"+now.toString());
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
  signUpUser() async {
    try {

      if(origCtrl.text.toString()!=""){
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
            .then((value) {
          String uid = value.user!.uid;
          userCollection.doc(uid).set({
            "username": _usernameController.text,
            "email": _emailController.text,
            "dateNaissance": datenaissancerpl.text,
            "adresse": origCtrl.text.toString(),
            "tel":_telController.text,
            "img":_photoController.text,
            "password": _passwordController.text,
            "uid": uid,
            "role": _roleController.text,
          });
        });
        Navigator.of(context).pop();
      }




    } catch (err) {
      print(err);
      var snackBar = SnackBar(
        content: Text(
          err.toString().substring(30),
          style: ralewayStyle(15),
        ),
      );
      //  _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  void getResults() {
    _fireStore.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach(
            (DocumentSnapshot documentSnapshot) {
          print("documentSnapshot.data()");
          print(documentSnapshot.data());
          setState(() {
            //  results.add(documentSnapshot.data()!["type"]);
          });
          // prints all the documents available
          // in the collection
          debugPrint(documentSnapshot.data.toString());
        },
      );
    });
  }
  @override
  void initState() {
    setState(() {
      //  _role=results.first;

      geoMethods.autocompletePlace(query: 'place streets or reference'); // It will search in unite states, espain and colombia. It just can filter up to 5 countries.
      geoMethods.geoLocatePlace(coords: Coords(0.10, 0.10));
      geoMethods.getPlaceGeometry(reference: 'place streets', placeId: 'ajFDN3662fNsa4hhs42FAjeb5n');
      geoMethods.getDirections(origin: Address(coords: Coords(0.10, 0.10)), destination: Address(coords: Coords(0.10, 0.10)));
    });
    getResults();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
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

                         value:_role ,
                         //elevation: 5,
                         style: TextStyle(color: Colors.black),


                         items: <String>[
                           'Restaurateur',
                           'Livreur',
                           'Client'

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

                                 child: Text("Profil",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),

                               )
                             ],
                           )

    ),
                         onChanged: (String? value) {
                           setState(() {
                             _role=value!;
                             _roleController.text=value;
                           });
                         }

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
                          controller: _usernameController,
                          style: montserratStyle(18, Colors.white),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            hintText: "Prenom et nom",
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
                  InkWell(
                    onTap: (){
                      DatePicker.showDatePicker(context, showTitleActions: true,
                          onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            if(date.month.toString().split('').length==1 && date.day.toString().split('').length==1){
                              setState(() {


                                datenaissancerpl.text=


                                    date.year.toString()+"-0"+date.month.toString()+"-0"+date.day.toString();

                              });

                            } else if(date.month.toString().split('').length!=1 && date.day.toString().split('').length==1){
                              setState(() {


                                datenaissancerpl.text=


                                    date.year.toString()+"-"+date.month.toString()+"-0"+date.day.toString();

                              });

                            } else if(date.month.toString().split('').length==1 && date.day.toString().split('').length!=1){


                              setState(() {


                                datenaissancerpl.text=


                                    date.year.toString()+"-0"+date.month.toString()+"-"+date.day.toString();

                              });


                            }else if(date.month.toString().split('').length!=1 && date.day.toString().split('').length!=1){
                              setState(() {


                                datenaissancerpl.text=


                                    date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString();

                              });


                            }


                            print('confirm $date');
                          },
                          currentTime: DateTime.utc(DateTime.now().year,DateTime.now().month ,DateTime.now().day, 23, 12, 34),
                          locale: LocaleType.fr);
                    },
                    child: Container(
                        height: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide( //                    <--- top side
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                            //  borderRadius: BorderRadius.circular(10),
                              //color: Colors.transparent
                          )),
                          // height: 20,
                          width: MediaQuery.of(context).size.width / 1.3,
                              child: Row(
                              children: [
                              SizedBox(
                              width: 15,
                              ),
                                Icon(Icons.date_range,color: Colors.white),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                datenaissancerpl.text=="" ?  "Date  de naissance ":
                                datenaissancerpl.text.split('-')[2]+"-"+  datenaissancerpl.text.split('-')[1]+"-"+   datenaissancerpl.text.split('-')[0] ,
                                style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color:Colors.white,
                                ),

                                ),

                              ],
                              )
                    )
                          ),


                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async{
                          var url=  await upload();
                          setState(() {
                            _photoController.text=url;
                          });

                          print(url);
                        },
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

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent
                        ),
                        width: MediaQuery.of(context).size.width / 1.3,
                        margin: EdgeInsets.all(10),
                        // height: 20,
                        child:  RouteSearchBox(
                          geoMethods: geoMethods,
                          originCtrl: origCtrl,
                          destinationCtrl: destCtrl,
                          builder: (context, originBuilder, destinationBuilder,
                              waypointBuilder, waypointsMgr, relocate, getDirections) {
                            //    if (origCtrl.text.isEmpty)
                            //    relocate(AddressId.origin, _initialPositon.toCoords());
                            return Container(
                              //height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent
                                ),
                                // height: 20,
                                width: MediaQuery.of(context).size.width / 1.3 ,
                              //padding: EdgeInsets.symmetric(horizontal: 15.0),
                              //   color: Colors.green[50],
                             //height: 150.0,

                                child:Column(
                                children: [
                                  TextField(
                                    style: montserratStyle(14, Colors.white),
                                    decoration: InputDecoration(
                                        hintText: "Adresse",
                                        prefixIcon: Icon(Icons.location_city,color: Colors.white),
                                        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                                  hintStyle: ralewayStyle(
                                    20,
                                    Colors.white,
                                  )),
                                    controller: origCtrl,
                                    onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => originBuilder.buildDefault(
                                        builder: AddressDialogBuilder(),
                                        onDone: (address) => (){
                                          print("address" );
                                          print(origCtrl.text);
                                          print(address);
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              );
                          },
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

                          child : TextField(
                          controller: _emailController,
                          style: montserratStyle(14, Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email,color: Colors.white),
                            hintStyle: ralewayStyle(
                              20,
                              Colors.white,
                            )),
                        ),
                                ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                       // height: 55,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide( //                    <--- top side
                                    color: Colors.white,
                                    width: 1.0,
                                  )
                              //borderRadius: BorderRadius.circular(10),
                              //color: Colors.transparent
                          )),
                           width: MediaQuery.of(context).size.width / 1.4,

                              child:
                          InternationalPhoneNumberInput(

                            onInputChanged: (PhoneNumber number1) {
                              setState(() {
                                _telController.text=number1.phoneNumber!;
                              });
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,

                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: Colors.white),
                            textStyle:montserratStyle(14, Colors.white),
                            initialValue: number,
                            textFieldController: controller,
                            formatInput: false,
                            // cursorColor: Colors.white,
                            inputDecoration: InputDecoration(
                              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                              hintText: "Telephone",
                                hintStyle: ralewayStyle(
                                  20,
                                  Colors.white,
                                ),
                            //  hintStyle: TextStyle(color: Colors.black),

                            ),

                            keyboardType:
                            TextInputType.numberWithOptions(signed: true, decimal: true),


                            /// inputBorder: OutlineInputBorder(),
                            onSaved: (PhoneNumber number1) {
                              setState(() {
                                _telController.text=number1.toString();
                              });
                              // print('On Saved: $number');
                            },
                          )),
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

                          child:TextField(
                          controller: _passwordController,
                          style: montserratStyle(18, Colors.white),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white,width:1 )),
                            hintText: "Mot de passe",
                            prefixIcon: Icon(Icons.lock,color: Colors.white),
                              hintStyle: ralewayStyle(
                                20,
                                Colors.white,
                              ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                     ),
                      SizedBox(
                        height: 40,
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
                              "S'inscrire",
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
