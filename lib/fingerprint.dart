// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_editor_sdk/photo_editor_sdk.dart';

class FingerprintRecognitionUI extends StatefulWidget {
  const FingerprintRecognitionUI({Key? key}) : super(key: key);

  @override
  _FingerprintRecognitionUIState createState() =>
      _FingerprintRecognitionUIState();
}

class _FingerprintRecognitionUIState extends State<FingerprintRecognitionUI> {
  File? _imageFile;

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

_submitFingerprint() {}
