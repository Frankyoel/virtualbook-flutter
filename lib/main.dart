// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_final_flutter/pages/login_page.dart';
import 'package:trabajo_final_flutter/pages/registro_page.dart';
import 'package:trabajo_final_flutter/pages/wrapper.dart';
import 'package:trabajo_final_flutter/services/auth_services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_)=> AuthService()),
      ],
      child: MaterialApp(
        title: 'VirtualBook',
        debugShowCheckedModeBanner: false,
       initialRoute: '/',
       routes: {
        '/':(context) => Wrapper(),
        '/login':(context) => LoginPage(),
        '/registrar':(context) => RegisterPage(),
       },
      ),
    );
  }
}