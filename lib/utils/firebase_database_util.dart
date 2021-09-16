import 'dart:async';
import 'dart:convert';


import 'package:firebase_database/firebase_database.dart';
import 'package:senfood/mdele/commande.dart';
import 'package:senfood/mdele/repas.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirebaseDatabaseUtil {
  DatabaseReference? _counterRef;
  DatabaseReference? _repasRef;
  DatabaseReference? _commandeRef;


  StreamSubscription<Event>? _counterSubscription;
  StreamSubscription<Event>? _messagesSubscription;
  FirebaseDatabase database = new FirebaseDatabase();
  int? _counter;
  DatabaseError? error;

  static final FirebaseDatabaseUtil _instance =
  new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    // Demonstrates configuring to the database using a file
    _counterRef = FirebaseDatabase.instance.reference().child("nbr");
    // Demonstrates configuring the database directly

    _repasRef = database.reference().child("repas");
    _commandeRef = database.reference().child("commande");

    database.reference().child('nbr').once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _counterRef!.keepSynced(true);

    _counterSubscription = _counterRef!.onValue.listen((Event event) {
      error = null;
      _counter = event.snapshot.value ?? 0;
    }, onError: (Object o) {
      error = o as DatabaseError?;
    });
  }


  DatabaseError? getError() {
    return error;
  }

  int? getCounter() {
    return _counter;
  }

  DatabaseReference? getRepas() {
    return _repasRef;
  }

  DatabaseReference? getCommandes() {
    return _commandeRef;
  }


  addCommande(Commande c) async {
    final TransactionResult transactionResult =
    await _counterRef!.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _commandeRef!.push().set(<String, dynamic>{
        "iduser": "" + c.userid,
        "idresto": "" + c.uid,
        "etat":  false,

      }).then((_) {
        return _;
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error!.message);
      }
    }
  }
  addRepas(Repas repas) async {
    final TransactionResult transactionResult =
    await _counterRef!.runTransaction((MutableData mutableData) async {
      mutableData.value = (mutableData.value ?? 0) + 1;

      return mutableData;
    });

    if (transactionResult.committed) {
      _repasRef!.push().set(<String, dynamic>{
        "nom": "" + repas.nom!,
        "img": "" + repas.img!,
        "uid": "" + repas.uid,
        "categorie": "" + repas.categorie!,
        "description": "" + repas.description!,
        "prix": repas.prix!,
        "quantite": repas.quantite!,
        "etat":  false,

      }).then((_) {
        print('Transaction  committed.');
      });
    } else {
      print('Transaction not committed.');
      if (transactionResult.error != null) {
        print(transactionResult.error!.message);
      }
    }
  }
  void delete1(Commande c) async {
    await _commandeRef!.child(c.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }
  void delete(Repas repas) async {
    await _repasRef!.child(repas.id).remove().then((_) {
      print('Transaction  committed.');
    });
  }
  void archiver(Repas repas, bool x) async {
    await _repasRef!.child(repas.id).update({
      "etat":x ,

    }).then((_) {
      print('Transaction  committed.');
    });
  }

  void valider(Repas pv) async {
    await _repasRef!.child(pv.id).update({
      "etat":true ,

    }).then((_) {
      print('Transaction  committed.');
    });
  }




  void dispose() {
    _messagesSubscription!=null? _messagesSubscription!.cancel():null;
    _counterSubscription!.cancel();
  }
}