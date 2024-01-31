import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mypolling/screens/code_page.dart';
import 'dart:math';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
import 'package:mypolling/screens/sign_up_page.dart';
import 'package:mypolling/screens/transition_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_page.dart';

class pageEmail extends StatefulWidget {
  const pageEmail({super.key});

  @override
  State<pageEmail> createState() => _pageEmailState();
}

class _pageEmailState extends State<pageEmail> {
  late Size mediaSize;
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  String generateResetCode() {
    // Générer un code aléatoire
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();
    const codeLength = 8;
    return List.generate(codeLength, (index) => chars[random.nextInt(chars.length)]).join();
  }


  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      const CircularProgressIndicator(backgroundColor: Colors.blue);

      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: const Text("Un mail a été envoyé à votre adresse mail. Veuillez consulter votre adresse électronique"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          TransitionFromButtomZoomOut(widget: const LoginPage()),
                              (Route<dynamic> route) => false
                      );
                    },
                    child: const Text("D'accord", style: TextStyle(color: Colors.blue),))
              ],
            );
          }
      );
    } catch(e){

      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text(e.toString()),
            );
          }
      );
    }
  }

  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context){
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(top: 50, child: _buildTop()),
        Positioned(bottom: 0, child: _buildBottom1()),
        Positioned(bottom: 0, child: _buildBottom()),
      ]),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          //image de vote
          Center(
            child: Image(
              image: AssetImage('assets/images/img.png'),
              width: 150,
              height: 150,
            ),
          )
        ],
      ),
    );
  }

  //Card en couleur bleu qui est derrière le card blanc
  Widget _buildBottom1() {
    return SizedBox(
      width: mediaSize.width,
      height: 325,
      child: Card(
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'CONNECTER',
                    style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {

                        Navigator.pushReplacement(
                            context,
                            TransitionFromRight(widget: const LoginPage())
                          // MaterialPageRoute(
                          //     builder: (context) => const LoginPage())
                        );
                      },
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'S\'INSCRIRE',
                    style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                            context,
                            TransitionFromLeft(widget: const SignupPage())
                          // MaterialPageRoute(
                          //     builder: (context) => const SignupPage())
                        );
                      },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //Card en couleur blanc qui est au dessus le card bleu
  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(
            key: formkey,
          ),
        ),
      ),
    );
  }

  //Notre formulaire
  Widget _buildForm({required GlobalKey<FormState> key}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGreyText("address email"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildLoginButon(),
      ],
    );
  }

  //Nos textes ecrit en gris(Widgets)
  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  //Nos input (Widgets)
  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.done),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      obscureText: isPassword,
    );
  }

  //Le bouton Login(Widgets)
  Widget _buildLoginButon() {
    return ElevatedButton(
        onPressed: () {
          String code = generateResetCode();
          CollectionReference snapshoot = FirebaseFirestore.instance.collection('CodeReset');
          snapshoot
              .add({
            'User': emailController.text.trim(),
            'code': code,
            'email': 'john.doe@example.com',
          })
              .then((value) => print("Données ajoutées avec succès"))
              .catchError((error) => print("Erreur lors de l'ajout des données: $error"));

          const CircularProgressIndicator(backgroundColor: Colors.blue);
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                    content: Text("Un email de rénitialisation de mot de passe à été envoyé à ${emailController.text.trim()}. Veuillez consulter votre adresse électronique."),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                TransitionFromCenterZoomIn(widget: const CodeResetPage())
                            );
                          },
                          //style: ButtonStyle(
                            //  backgroundColor: Colors.blue
                          //),
                          child: const Text('D\'accord')
                      )
                    ]
                );
              }

          );
          passwordReset();
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.blue,
          backgroundColor: Colors.blue,
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text("ENVOYER",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20)));
  }


}
