import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:study_material_bank/screens/home_page.dart';
import 'package:study_material_bank/utils/animated_page_route.dart';
import 'package:study_material_bank/utils/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MySplash(),
  );
}

class MySplash extends StatelessWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: Column(
          children: [
            Image.asset(
              'assets/icon-splash.png',
              width: 120,
              height: 120,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 90.0),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: kColor2,
              ),
            ),
          ],
        ),
        nextScreen: MyApp(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: 250.0,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // initialization Future
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error in Firebase Initialisation'),
          );
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Study Material Bank',
            home: LandingPage(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgressIndicator();
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFC16EE4),
        title: Text(
          "Study Time",
          style: GoogleFonts.iceberg(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Exams nearing? We got you!',
                    textStyle: GoogleFonts.lemonada(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    speed: const Duration(milliseconds: 120),
                  ),
                ],
                totalRepeatCount: 10,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: false,
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/landing-1.jpg",
              ),
              const SizedBox(
                height: 80,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    AnimatedPageRoute(
                      const HomePage(),
                    ),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                    gradient: kButtonGradient,
                  ),
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Let's Study",
                      style: GoogleFonts.lemonada(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
