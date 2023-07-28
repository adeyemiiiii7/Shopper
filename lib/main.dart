import 'package:flutter/material.dart';
import 'package:shooper/widgets/grocery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Groceries',
        theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(250, 2, 30, 36),
            brightness: Brightness.dark,
            surface: const Color.fromARGB(250, 2, 8, 15),
          ),
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 5, 6),
        ),
        home: const GroceryList());
  }
}
