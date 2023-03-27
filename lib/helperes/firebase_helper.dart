import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireHelper {
  FireHelper._();

  static FireHelper fireHelper = FireHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> registerUser(String email, String password) async {
    bool isRegister = false;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      isRegister = true;
    }).catchError((error) {
      isRegister = false;
    });
    return isRegister;
  }

  bool checkLogin() {
    if (firebaseAuth.currentUser != null) {
      return true;
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    bool isLogin = false;

    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      isLogin = true;
    }).catchError((error) {
      isLogin = false;
    });
    return isLogin;
  }

  //========================Firestore================================

  Future<void> addData(
      {required String ProductName,
        required String ProductPrice,
        required String ProductDes,
        required String ProductImage,
        required String ProductCategory}) async {
    print(ProductCategory);
    await firebaseFirestore.collection("product").add({
      "ProductName": ProductName,
      "ProductPrice": ProductPrice,
      "ProductDes": ProductDes,
      "ProductImage": ProductImage,
      "ProductCategory": ProductCategory,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>readData() {
    return firebaseFirestore.collection("product").snapshots();
  }
}
