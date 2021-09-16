import 'package:firebase_database/firebase_database.dart';

class Commande {

  String? _id;
  String? _uid;
  String? _userid;
  //user added
  bool? _etat;


  Commande(this._userid,this._etat,this._uid);
  String get id => _id!;

  String get uid => _uid!;
  String get userid => _userid!;

  bool? get etat => _etat;

  Commande.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _uid = snapshot.value['idresto'];
    _userid = snapshot.value["iduser"];
    _etat = snapshot.value['etat'];

  }

}