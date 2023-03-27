import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_firebase_jet/views/HomePages.dart';
import 'package:my_firebase_jet/views/Splash_Screen.dart';
import 'package:my_firebase_jet/views/login_page.dart';
import 'package:my_firebase_jet/views/register_page.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Splash_screen(),
        'Login': (context) => const Login(),
        'Register': (context) => const Register(),
        'HomePage': (context) => const HomePage(),
      },
    ),
  );
}