import 'package:firebase_database/firebase_database.dart';

class Repas {

  String? _id;
  String? _uid;
  String? _nom;
  int? _prix ;
  String? _description;
  String? _categorie;
  String? _img;
  int? _quantite;
  //user added
  bool? _etat;


  Repas(this._id,this._nom,this._prix,this._etat,this._description,this._categorie,this._img,this._quantite,this._uid


      );


  String get id => _id!;
  String get uid => _uid!;
  bool? get etat => _etat;
  String? get nom => _nom;
  String? get description => _description;
  String? get categorie => _categorie;
  String? get img => _img;
  int? get quantite => _quantite;
  int? get prix => _prix;

  Repas.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _uid = snapshot.value['uid'];
    _nom = snapshot.value['nom'];
    _etat = snapshot.value['etat'];
    _description = snapshot.value['description'];
    _categorie = snapshot.value['categorie'];
    _img = snapshot.value['img'];
    _quantite = snapshot.value['quantite'];
    _prix = snapshot.value['prix'];
  }

}