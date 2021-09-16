import 'package:firebase_database/firebase_database.dart';

class Item {

  String? _id;
  String? _uid;
  String? _rid;
  String? _userid;
  int? _prix ;
  String? _nom;
  String? _categorie;
  String? _img;
  int? _quantite;
  //user added
  bool? _etat;


  Item(this._id,this._rid,this._userid,this._prix,this._etat,this._img,this._quantite,this._uid,this._nom,this._categorie);


  String get id => _id!;
  String get uid => _uid!;
  String get rid => _rid!;
  String get userid => _userid!;
  String get nom=> _nom!;
  String get categorie => _categorie!;
  bool? get etat => _etat;
  String? get img => _img;
  int? get quantite => _quantite;

  int? get prix => _prix;
  set quantites( int q){
    _quantite=q;

  }

  Item.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _uid = snapshot.value['uid'];
    _rid = snapshot.value['rid'];
    _userid = snapshot.value['userid'];
    _nom = snapshot.value['nom'];
    _categorie = snapshot.value['categorie'];
    _etat = snapshot.value['etat'];
    _img = snapshot.value['img'];
    _quantite = snapshot.value['quantite'];
    _prix = snapshot.value['prix'];
  }

}