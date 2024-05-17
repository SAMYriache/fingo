// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_import, unused_field

import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:photo_editor_sdk/photo_editor_sdk.dart';
import 'package:fingo_app/NavBar.dart';

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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: const Color(0xFF131313),
  //     appBar: AppBar(
  //       title: const Text('Fingerprint Recognition',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 30,
  //             fontWeight: FontWeight.bold,
  //             fontStyle: FontStyle.italic,
  //           )),
  //       backgroundColor: Colors.black,
  //       centerTitle: true,
  //     ), // Set the background color
  //     body: Container(
  //         width: 1000,
  //         height: 1000,
  //         child: Column(children: [
  //           Image.network(
  //             'https://media.wired.com/photos/5bef60888cd3bb7c5ea63882/master/w_1920,c_limit/Fingerprints-182668331.jpg', // Replace with the correct path to the image
  //             fit: BoxFit.cover,
  //           ),
  //           MaterialButton(
  //             color: Color.fromARGB(255, 17, 197, 218),
  //             textColor: Colors.white,
  //             onPressed: () {
  //               print("hi");
  //             },
  //             child: Text("selctioner une photo"),
  //           ),
  //           MaterialButton(
  //             color: Color.fromARGB(255, 17, 197, 218),
  //             textColor: Colors.white,
  //             onPressed: () {
  //               print("hi");
  //             },
  //             child: Text("Prendre une photo d'une empreinte"),
  //           ),
  //           MaterialButton(
  //             color: Color.fromARGB(255, 17, 197, 218),
  //             textColor: Colors.white,
  //             padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
  //             onPressed: () {
  //               print("hi");
  //             },
  //             child: Text("Submit"),
  //           )
  //         ])),

  //     // Scaffold(
  //   );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Navbar(),
        backgroundColor: const Color(0xFF131313),
        appBar: AppBar(
          title: const Text('Fingerprint Recognition',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              )),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // Image en arrière-plan
            Positioned.fill(
              child: Image.network(
                'https://media.wired.com/photos/5bef60888cd3bb7c5ea63882/master/w_1920,c_limit/Fingerprints-182668331.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Contenu superposé
            Center(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 10.0),
                  //       child: Icon(
                  //         Icons.menu,
                  //         size: 40,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 15.0),
                  //       child: const Text('Fingerprint Recognition',
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 30,
                  //             fontWeight: FontWeight.bold,
                  //             fontStyle: FontStyle.italic,
                  //           )),
                  //     )
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 80),
                    child: MaterialButton(
                      color: Color.fromARGB(255, 10, 39, 40),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Bordure arrondie
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      onPressed: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                      child: Text(
                        "Choose a photo",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 80),
                    child: MaterialButton(
                      color: Color.fromARGB(255, 10, 39, 40),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Bordure arrondie
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      onPressed: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                        ;
                      },
                      child: Text(
                        "Take a photo",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 300.0, horizontal: 120),
                    child: MaterialButton(
                      color: Color.fromARGB(255, 10, 39, 40),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Bordure arrondie
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      onPressed: () {
                        print("hi");
                      },
                      child: Text(
                        "submit",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
              // Espace flexible en-dessous des boutons
            ),
            Spacer(flex: 8),
          ],
        ));
  }

  // Scaffold(

  // // backgroundColor: Color.fromARGB(255, 130, 48, 48),
  // appBar: AppBar(
  //   title: const Text('Fingerprint Recognition',
  //       style: TextStyle(color: Colors.white)),
  //   backgroundColor: const Color(0xFF131313),
  // ),
  // body: Center(

  //   child: Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           foregroundColor: Colors.black,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8)),
  //           padding:
  //               const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
  //           textStyle: const TextStyle(fontWeight: FontWeight.bold),
  //           shadowColor: const Color(0xffc6d8ff),
  //           elevation: 5,
  //           surfaceTintColor: Colors.white,
  //           backgroundColor: const Color(0xffe5f0ff),
  //         ),
  //         onPressed: () {
  //           showModalBottomSheet<void>(
  //             context: context,
  //             backgroundColor: const Color(0xFF131313),
  //             builder: (BuildContext context) {
  //               return Container(
  //                   color: const Color(0xFF131313),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: <Widget>[
  //                       ListTile(
  //                         leading: const Icon(Icons.photo_library),
  //                         title: const Text('Choose from Gallery',
  //                             style: TextStyle(color: Colors.white)),
  //                         onTap: () {
  //                           Navigator.pop(context);
  //                           _pickImage(ImageSource.gallery);
  //                         },
  //                       ),
  //                       ListTile(
  //                         leading: const Icon(Icons.camera_alt),
  //                         title: const Text('Take a Picture',
  //                             style: TextStyle(color: Colors.white)),
  //                         onTap: () {
  //                           Navigator.pop(context);
  //                           _pickImage(ImageSource.camera);
  //                         },
  //                       ),
  //                     ],
  //                   ));
  //             },
  //           );
  //         },
  //         child: const Text('Attach Fingerprint Image'),
  //       ),
  //       ElevatedButton(
  //         onPressed: _imageFile != null
  //             ? _submitFingerprint
  //             : null, // Enable only if image exists
  //         child: const Text('Submit'),
  //       ),
  //     ],
  //   ),
  // ),
}
