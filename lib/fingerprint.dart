// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:photo_editor_sdk/photo_editor_sdk.dart';
import 'package:fingo_app/NavBar.dart'; // Assuming NavBar is correctly imported from its file

class FingerprintRecognitionUI extends StatefulWidget {
  const FingerprintRecognitionUI({Key? key}) : super(key: key);

  @override
  _FingerprintRecognitionUIState createState() =>
      _FingerprintRecognitionUIState();
}

class _FingerprintRecognitionUIState extends State<FingerprintRecognitionUI> {
  XFile? _imageFile;
  bool _isLoading = false;
  bool _matchFound = false;
  Map<String, dynamic>? _fingerprintData;

  _submitFingerprint() async {
    EasyLoading.show();
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    if (_imageFile == null) {
      print("No file selected.");
      setState(() {
        _isLoading = false;
      });
      EasyLoading.dismiss();
      return;
    }

    final apiUrl = Uri.parse('http://192.168.133.173:5000/classify_and_match');
    final request = http.MultipartRequest('POST', apiUrl);
    request.files.add(await http.MultipartFile.fromPath(
        'file', _imageFile!.path,
        contentType: MediaType('image', 'BMP')));

    try {
      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final result = json.decode(responseData);

      print('API Result: $result');

      setState(() {
        _isLoading = false;
        _fingerprintData = result;
      });

      if (_fingerprintData!['matching']['best_match_file'] != null) {
        _showSuccessDialog();
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        final image = img.decodeImage(imageBytes);

        print('Image Width: ${image!.width}, Height: ${image.height}');

        setState(() {
          _imageFile = pickedFile;
        });
        _showEditRetake(pickedFile.path);
      } else {
        return;
      }
      print('File Path: ${_imageFile?.path}');
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> _openEditor() async {
    if (_imageFile != null) {
      final result = await PESDK.openEditor(image: _imageFile!.path);
      print(result?.toJson());
    }
  }

  _showEditRetake(String imagePath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(File(imagePath)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _openEditor();
                  },
                  child: const Text('Modifier'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'), // Change this line
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          'Correspondance trouvée !',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.file(File(_imageFile!.path)),
            const SizedBox(height: 10),
            const Text(
              'Nom & Prénom: Mohamed Belhachheb',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              'L\'adresse de naissance: 12/02/1966',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              'Addresse: 23 Rue Allout Ahcene (Ex Y)',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              'Ville: Alger',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              'ID: 230546872',
              style: TextStyle(color: Colors.white),
            ),
            const Text(
              'Passport: Pas De Passeport',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(), // Use the NavBar
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // Add this line
        title: const Text(
          'Fingerprint Recognition',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/fingerprint_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 80),
                  child: MaterialButton(
                    color: const Color.fromARGB(255, 10, 39, 40),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    onPressed: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: const Text(
                      "Choisissez une photo",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 80),
                  child: MaterialButton(
                    color: const Color.fromARGB(255, 10, 39, 40),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    onPressed: () {
                      _pickImage(ImageSource.camera);
                    },
                    child: const Text(
                      "Prendre une photo",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 300.0, horizontal: 120),
                  child: MaterialButton(
                    color: const Color.fromARGB(255, 10, 39, 40),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    onPressed: _submitFingerprint,
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}