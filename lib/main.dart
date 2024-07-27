import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'screens/splash_screen.dart';
//import 'screens/login_screen.dart';
import 'screens/color_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/parent_screen.dart';
import 'screens/paint_screen.dart';
import 'screens/main_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sandBox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/main_menu',
      routes: {
        //'/': (context) => SplashScreen(),
        //'/login': (context) => LoginScreen(),
        '/main_menu': (context) => MainScreen(),
        '/paint': (context) => PaintScreen(),
        '/learn': (context) => LearnScreen(),
        '/color': (context) => ColorScreen(),
        '/parent': (context) => ParentScreen(),
      },
    );
  }
}
