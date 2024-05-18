import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importer ce package

void _showExitConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF131313),
        title: const Text(
          "Confirm Exit",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Êtes-vous sûr de vouloir quitter ?",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text("Annuler"),
            onPressed: () {
              Navigator.of(context).pop(); // Fermer la boîte de dialogue
            },
          ),
          TextButton(
            child: const Text("Quitter"),
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
        foregroundColor: Colors.white, // Add this line
        title: const Text(
          'Informations de contact',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFF131313),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(10),
        child: const Column(
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
            Text('UNE RÉCLAMATION ? N\'HÉSITEZ PAS, ÉCRIVEZ-NOUS !',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center),
            SizedBox(height: 20),
            Text(
              'Nom : Riache Samy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Téléphone : 0552473041',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email : \nsamyriache2@gmail.com',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 80),
            Text(
              'Nom : AMMAR BOUDJELAL CHAKIB',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Téléphone : 0657473334',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Email : chakibammarboudjelal@gmail.com',
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
        foregroundColor: Colors.white,
        title: const Text(
          'Comment utiliser l\'application',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFF131313),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.all(10),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Comment utiliser l\'application de reconnaissance d\'empreintes digitales',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '1. Choisissez une photo',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Sélectionnez une photo d\'empreinte digitale depuis votre galerie en appuyant sur le bouton "Choisir une photo".',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '2. Prenez une photo',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Prenez une nouvelle photo d\'empreinte digitale en utilisant votre appareil photo en appuyant sur le bouton "Prendre une photo".',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '3. Soumettre',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Après avoir sélectionné ou capturé une photo, appuyez sur le bouton "Soumettre" pour démarrer le processus de reconnaissance d\'empreintes digitales.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '4. Voir les résultats',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'L\'application traitera l\'empreinte digitale et affichera les informations de la personne associée à l\'empreinte digitale.',
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
      width: 250,
      shadowColor: Colors.white,
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              drawerTile(Icons.brightness_4, "Mode"),
              drawerTile(Icons.question_mark_outlined, "Comment utiliser?",
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HowToUsePage()),
                );
              }),
              drawerTile(Icons.contacts, "Contacts", onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPage()),
                );
              }),
              drawerTile(Icons.logout, "Quitter", onTap: () {
                _showExitConfirmation(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget drawerTile(IconData icon, String text, {Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    ),
  );
}
