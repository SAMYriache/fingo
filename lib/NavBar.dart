import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importer ce package

void _showExitConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF131313),
        title: Text(
          "Confirm Exit",
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          "Are you sure you want to exit?",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Fermer la boîte de dialogue
            },
          ),
          TextButton(
            child: Text("Exit"),
            onPressed: () {
              SystemNavigator.pop(); // Quitter l'application
            },
          ),
        ],
      );
    },
  );
}

//contact page

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Information',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFF131313),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '    CONTACTEZ-NOUS  ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text('UNE RECLAMATION ? N\'HESITEZ PAS , ECRIVEZ-NOUS !',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center),
            SizedBox(height: 20),
            Text(
              'Name : Riache Samy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: 0552473041',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: \nsamyriache2@gmail.com',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 80),
            Text(
              'Name: AMMAR BOUDJELAL CHAKIB',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: 0657473334',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email: chakibammarboudjelal@gmail.com',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// how to use app
class HowToUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'How to Use the App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFF131313),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How to Use the Fingerprint Recognition App',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '1. Choose a Photo',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Select a fingerprint photo from your gallery by tapping on the "Choose a photo" button.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '2. Take a Photo',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Capture a new fingerprint photo using your camera by tapping on the "Take a photo" button.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '3. Submit',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'After selecting or capturing a photo, tap on the "Submit" button to start the fingerprint recognition process.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '4. View Results',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'The app will process the fingerprint and display the information of the person associated with the fingerprint.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: Colors.white,
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.white,
      child: ListView(
        children: [
          Spacer(),
          ListTile(
            leading: Icon(
              Icons.brightness_4,
              color: Colors.white,
            ),
            title: Text(
              "mode",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(
              Icons.assignment_turned_in,
              color: Colors.white,
            ),
            title: Text(
              "How to Use ?",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HowToUsePage()),
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              title: Text(
                "Contacts",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPage()),
                  )),
          // ListTile(
          //   leading: Icon(
          //     Icons.share,
          //     color: Colors.white,
          //   ),
          //   title: Text(
          //     "Share App",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.star,
          //     color: Colors.white,
          //   ),
          //   title: Text(
          //     "Rate us ",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(
          //     Icons.toll,
          //     color: Colors.white,
          //   ),
          //   title: Text(
          //     "More apps and tools",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   onTap: () => null,
          // ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              "Exit ",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => _showExitConfirmation(
                context), // Appeler la méthode de confirmation
          ),
        ],
      ),
    );
  }
}
