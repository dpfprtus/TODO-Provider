import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth_provider/pages/home_page.dart';
import 'package:fb_auth_provider/pages/signin_page.dart';
import 'package:fb_auth_provider/pages/signup_page.dart';
import 'package:fb_auth_provider/pages/splash_page.dart';
import 'package:fb_auth_provider/providers/auth/auth_provider.dart';
import 'package:fb_auth_provider/providers/signin/signin_provider.dart';
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

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
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: fbAuth.FirebaseAuth.instance),
        ),
        StreamProvider<fbAuth.User?>(
            create: (context) => context.read<AuthRepository>().user,
            initialData: null),
        ChangeNotifierProxyProvider<fbAuth.User?, AuthProvider>(
            create: (context) => AuthProvider(
                  authRepository: context.read<AuthRepository>(),
                ),
            update: (BuildContext context, fbAuth.User? userStream,
                    AuthProvider? authProvider) =>
                authProvider!..update(userStream)),
        ChangeNotifierProvider<SigninProvider>(
          create: (context) => SigninProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Auth Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashPage(),
        routes: {
          SignupPage.routeName: (context) => SignupPage(),
          SigninPage.routeName: (context) => SigninPage(),
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}