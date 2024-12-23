import 'package:firebase.demo.app/data/firebase_auth_service.dart';
import 'package:firebase.demo.app/screens/create_acc_screen.dart';
import 'package:firebase.demo.app/screens/home_screen.dart';
import 'package:firebase.demo.app/screens/login_screen.dart';
import 'package:firebase.demo.app/screens/product_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuthService.authStateChanges,
        builder: (context, snapshot) {
          // neu nguoi dung log in thanh cong thi se tro ve man hinh chinh ProductScreen
          if (snapshot.hasData) {
            return const ProductScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
