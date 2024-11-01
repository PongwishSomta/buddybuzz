import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/authprovider.dart';
import 'page/loginpage.dart';
import 'page/registerpage.dart';
import 'page/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // ตรวจสอบว่ามีการเรียกใช้ Firebase.initializeApp()
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        title: 'buddybuzz',
        initialRoute: '/',
        routes: {
          '/': (context) => Consumer<AuthProvider>(
              builder: (context, authProvider, _) {
                return authProvider.user != null ? const HomePage() : LoginPage();
              }
          ),
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}

