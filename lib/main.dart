import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wicca_store_2/views/homepage.dart';
import 'package:wicca_store_2/views/landingpage.dart';
import 'package:wicca_store_2/views/signin.dart';
import 'package:wicca_store_2/views/signup.dart';
import 'package:wicca_store_2/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    return MaterialApp(
      title: 'Wicca',
      theme: ThemeData(
        textTheme: GoogleFonts.soraTextTheme(),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
      ),
      home: isLoggedIn ? SplashPage() : LandingPage(),
      routes: {
        "/home": (context) => HomePage(),
        "/signup": (context) => SignUpPage(),
        "/signin": (context) => SignInPage(),
        "/landingpage": (context) => LandingPage(),
      },
    );
  }
}
