import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_application/helper/functions.dart';
import 'package:quiz_application/views/home.dart';
import 'package:quiz_application/views/singin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    bool isLoggedin=false;
    @override
  void initState() {
      checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus()async{
     isLoggedin= (await HelperFunctions.getuserLoggedInDetails())!;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isLoggedin ? Home() : SignIn(),
    );
  }
}


