import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier_ex/provider/bg_color.dart';
import 'package:state_notifier_ex/provider/counter.dart';
import 'package:state_notifier_ex/provider/customer_level.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<BgColor, BgColorsState>(
          create: (context) => BgColor(),
        ),
        //ChangeProxyNotiferProvider보다 간편해졌다.
        StateNotifierProvider<Counter, CounterState>(
          create: (context) => Counter(),
        ),
        StateNotifierProvider<CustomerLevel, Level>(
          create: (context) => CustomerLevel(),
        )
      ],
      child: MaterialApp(
        title: 'StateNotifier',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StateNotifier'),
      ),
      body: Center(
        child: Text(
          '0',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Increment',
            child: Icon(Icons.add),
            onPressed: () {},
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            tooltip: 'Change Color',
            child: Icon(Icons.color_lens_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
