import 'package:flutter/material.dart';
import 'package:testt/view/donate.dart';
import 'package:testt/view/editprofile.dart';
import 'package:testt/view/explorerpage.dart';
import 'package:testt/view/login_page.dart';
import 'package:testt/view/messages.dart';
import 'package:testt/view/profile.dart';
import 'package:testt/view/usertype.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'package:testt/view/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wafra App',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        '/explore': (context) => const ExplorerPage(),
        '/user': (context) => const UserTypeScreen(),
        '/offer': (context) => const Donate(),
        '/profile': (context) => const ProfilePage(),
        '/msg': (context) => const MessagesPage(),
        '/edit': (context) => const EditProfilePage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('404 Not Found'),
          ),
        ),
      ),
      initialRoute: '/',
    );
  }
}
