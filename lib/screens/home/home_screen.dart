import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Home Screen',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
    );
  } // Close the build method properly
} // Close the _HomeScreenState class properly
