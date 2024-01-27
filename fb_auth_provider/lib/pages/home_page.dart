import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //뒤로가기 해도 뒤로 안가짐
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
