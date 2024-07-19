import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/features/auth/presentation/pages/login.dart';
import 'package:news/features/auth/presentation/pages/register.dart';
import 'package:news/features/auth/presentation/provider/auth_provider.dart';
import 'package:news/features/home/presentation/pages/home.dart';
import 'package:news/features/home/presentation/pages/profile.dart';
import 'package:news/features/home/presentation/providers/news_provider.dart';
import 'package:news/injector.dart';
import 'package:news/resourses/r.dart';
import 'package:news/utils/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeServices();
  await Future.wait([
    Firebase.initializeApp(),
    dotenv.load(fileName: '.env'),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LocalAuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'News',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: R.color.myBlue,
            background: R.color.veryLightBlue,
          ),
          useMaterial3: true,
        ),
        routes: {
          Constants.login: (context) => const LoginScreen(),
          Constants.home: (context) => const HomePage(),
          Constants.register: (context) => const RegisterScreen(),
          Constants.profile: (context) => const ProfilePage(),
        },
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
