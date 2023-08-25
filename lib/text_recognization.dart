import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:text_recognition_app/main.dart';

class TextRecontionScreen extends StatefulWidget {
  const TextRecontionScreen({super.key});

  @override
  State<TextRecontionScreen> createState() => _TextRecontionScreenState();
}

class _TextRecontionScreenState extends State<TextRecontionScreen> {
  File? _image;
  String text = '';
  Future _pickImage(ImageSource source) async {
    try {
      final Image = await ImagePicker().pickImage(source: source);
      if (Image == null) return;
      setState(() {
        _image = File(Image.path);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future textRecognition(File img) async {
    final textRecogizer = TextRecognizer(
      script: TextRecognitionScript.latin,
    );
    final inputImage = InputImage.fromFilePath(img.path);
    final RecognizedText recognizedText =
        await textRecogizer.processImage(inputImage);
    setState(() {
      text = recognizedText.text;
    });
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Recognition',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            right: 15,
            left: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: Colors.grey,
                child: Center(
                  child: _image == null
                      ? const Icon(
                          Icons.add_a_photo,
                          size: 60,
                        )
                      : Image.file(_image!),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.blue,
                child: MaterialButton(
                  onPressed: () {
                    _pickImage(ImageSource.camera).then(
                      (value) {
                        if (_image != null) {
                          textRecognition(_image!);
                        }
                      },
                    );
                  },
                  child: const Text(
                    'التقط صوره من الكاميرا',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.blue,
                child: MaterialButton(
                  onPressed: () {
                    _pickImage(ImageSource.gallery).then(
                      (value) {
                        if (_image != null) {
                          textRecognition(_image!);
                        }
                      },
                    );
                  },
                  child: const Text(
                    'اختر صوره من المعرض',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: SelectableText(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
