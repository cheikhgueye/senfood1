import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? username;
  final String?  adresse;
  final String?  email;
  final String?  img;

  final String?  password;
  final String?  role;
  final String?   tel;
  final String?   date;
  final String?   uid;





  UserModel({this.username,this.adresse,this.email,this.img,this.password,this.role,this.tel,this.uid,this.date});
  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold
  List<UserModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Object? dataMap = snapshot.data();
      var data=dataMap! as Map;

      return UserModel(
        username:data["username"],
        adresse: data['adresse'],
        email:data["email"],
        img: data["img"],
        password:data["password"],
        uid: data["uid"],
        date: data["dateNaissance"],
        role: data["role"],
        tel: data["tel"],



      );
    }).toList();
  }
}
