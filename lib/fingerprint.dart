// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_import, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:photo_editor_sdk/photo_editor_sdk.dart';

class FingerprintRecognitionUI extends StatefulWidget {
  const FingerprintRecognitionUI({Key? key}) : super(key: key);

  @override
  _FingerprintRecognitionUIState createState() =>
      _FingerprintRecognitionUIState();
}

class _FingerprintRecognitionUIState extends State<FingerprintRecognitionUI> {
  File? _imageFile;
  bool _isLoading = false;
  bool _matchFound = false;
  Map<String, dynamic>? _fingerprintData; // Store the data
  _submitFingerprint() async {
    EasyLoading.show();
    setState(() {
      _isLoading = true; // Start loading
    });

    // Simulate fingerprint matching (replace with your actual logic)
    await Future.delayed(const Duration(seconds: 3));

    // Replace with your database matching result
    bool hasMatch = true; // ... Your logic here

    if (hasMatch) {
      setState(() {
        _matchFound = true;
        _isLoading = false;
        _fingerprintData = {
          'name': 'John Doe',
          'age': 35,
          // ... other relevant data
        };
      });
      EasyLoading.dismiss(); // Optional (dismiss automatically)
      _showSuccessDialog();
    }
    // Handle case where no match is found
// Example
  }

  _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fingerprint Match Found!'),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Keep dialog compact
          children: [
            Text('Name: ${_fingerprintData!['name']}'),
            Text('Age: ${_fingerprintData!['age']}'),
            // ... More data if needed
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _openEditor();
    }
  }

  Future<void> _openEditor() async {
    if (_imageFile != null) {
      final result = await PESDK.openEditor(image: _imageFile!.path);
      print(result?.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        title: const Text('Fingerprint Recognition',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF131313),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                shadowColor: const Color(0xffc6d8ff),
                elevation: 5,
                surfaceTintColor: Colors.white,
                backgroundColor: const Color(0xffe5f0ff),
              ),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: const Color(0xFF131313),
                  builder: (BuildContext context) {
                    return Container(
                        color: const Color(0xFF131313),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Choose from Gallery',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Take a Picture',
                                  style: TextStyle(color: Colors.white)),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                          ],
                        ));
                  },
                );
              },
              child: const Text('Attach Fingerprint Image'),
            ),
            ElevatedButton(
              onPressed: _imageFile != null
                  ? _submitFingerprint
                  : null, // Enable only if image exists
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
