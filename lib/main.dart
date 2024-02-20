import 'dart:io';

import 'package:adifoodapp/helper/helper_function.dart';
import 'package:adifoodapp/provider/my_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/welcome_page.dart';
import 'screen/sign_up.dart';
import 'screen/login_page.dart';
import 'screen/home_page.dart';
import 'screen/search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyBC2MO6t8xI_wii9eh3gF-zC_eXy-QBAjI",
            appId: "1:28181494439:android:f3934d2a73fd76dc5c3982",
            messagingSenderId: "28181494439",
            projectId: "ad-farm-9cfcb",
          ),
        )
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: _isSignedIn
            ? HomePage()
            : WelcomePage(), //LoginPage(), //SignUp() //WelcomePage(),
        //HomePage(),
      ),
    );
  }
}
