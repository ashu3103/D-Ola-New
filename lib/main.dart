import 'package:dola/screens/pastRides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'authentication/homePage.dart';
import 'authentication/loginPage.dart';
import 'authentication/registerPage.dart';
import 'screens/home.dart';
import 'screens/prepare_ride.dart';
import 'ui/splash.dart';

late SharedPreferences sharedPreferences;

   Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: 
   DefaultFirebaseOptions.currentPlatform);
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'dola',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            textTheme:
                GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)),
        // home: const Splash()
         initialRoute: '/splash',
      routes: {
        '/splash':(context)=>const Splash(),
        '/' : (context) => const HomePage(),
        '/login' : (context) => const LoginPage(),
        '/register' : (context) =>const RegistrationPage(),
        '/home' : (context) =>const Home(),
        '/book_ride' : (context) =>const PrepareRide(),
        '/past_rides' : (context) =>const PastRides(),
      },
        );
  }
}
