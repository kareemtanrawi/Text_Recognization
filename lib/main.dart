import 'package:flutter/material.dart';
import 'package:text_recognition_app/text_recognization.dart';

void main() {
  runApp(const TextRecognization());
}

class TextRecognization extends StatelessWidget {
  const TextRecognization({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: ThemeData(
      //   useMaterial3: true,
      // ),
      debugShowCheckedModeBanner: false,
      home: TextRecontionScreen(),
    );
  }
}
