import 'package:cloud_firestore/cloud_firestore.dart';

class CommandeModel {
  final String? userid;
  final String?  restid;
  final bool?  etat;
  final int?  prix;
  final int?  quantite;

  final String?  categorie;
  final String?  img;
  final String?   nom;






  CommandeModel({this.userid,this.restid,this.etat,this.prix,this.categorie,this.img,this.nom,this.quantite});
  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold
  List<CommandeModel> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Object? dataMap = snapshot.data();
      var data=dataMap! as Map;

      return CommandeModel(
        userid:data["userid"],
        restid: data['restid'],
        etat:data["etat"],
        prix: data["prix"],
        quantite: data["quantite"],
        categorie:data["categorie"],
        img: data["img"],
        nom: data["nom"],




      );
    }).toList();
  }
}
