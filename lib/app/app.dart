import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/screens/screen.dart';



class MyResumeApp extends StatelessWidget {
  const MyResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(81, 59, 86, 1) ),
        useMaterial3: true,
        fontFamily: 'Caveat',
      ),
      home: const MyProfileScreen(),
    );
  }
}