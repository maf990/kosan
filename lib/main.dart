import 'package:kosan_app/pages/splash_page.dart';
import 'package:kosan_app/providers/space_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpaceProvider(),
      child: MaterialApp(
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
