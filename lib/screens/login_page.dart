import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mypolling/screens/dashboard_page.dart';
import 'package:mypolling/screens/sign_up_page.dart';
import 'package:mypolling/screens/page_email.dart';
import 'package:mypolling/screens/transition_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size mediaSize;
  bool isPassword = true;
  RegExp emailRegex = RegExp(r'^[a-zA-Z]+([0-9])*@[a-zA-Z]+.[a-zA-Z]{2,7}$');
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Fonction pour la connexion avec Firebase
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      const CircularProgressIndicator(backgroundColor: Colors.blue);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Connecté avec succès", style: TextStyle(color: Colors.yellow), textAlign: TextAlign.center,)),
      );
      // Navigue vers la page d'accueil après la connexion réussie
      Navigator.pushAndRemoveUntil(
        context,
        TransitionFromButtomRight(widget: const HomePage()),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la connexion: ${e.toString()}", style: const TextStyle(color: Colors.yellow))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Positioned(top: 50, child: _buildTop()),
          Positioned(bottom: 0, child: _buildBottom1()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
      height: 500,
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
                    text: 'CONNEXION',
                    style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(context,
                            TransitionFromLeft(widget: const LoginPage()));
                      },
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'INSCRIPTION',
                    style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(context,
                            TransitionFromRight(widget: const SignupPage()));
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreyText("Email address"),
          _buildInputFieldEmail(emailController),
          const SizedBox(height: 40),
          _buildGreyText("Password"),
          _buildInputFieldPassword(passwordController),
          const SizedBox(height: 20),
          _buildForgot(),
          const SizedBox(height: 20),
          _buildLoginButon(),
        ],
      ),
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
  Widget _buildInputFieldEmail(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
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
      validator: (value) {
        if(value == null || value.isEmpty){
          return "Ce champ ne peut pas être vide";
        }
        if(!emailRegex.hasMatch(emailController.text)){
          return "Le format de l'email n'est pas respecté";
        }

        return null;
      },
      autocorrect: true,
    );

  }

  Widget _buildInputFieldPassword(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: (isPassword)
              ? const Icon(Icons.visibility_off)
              : const Icon(Icons.visibility),
          onPressed: () {
            setState(() {
              isPassword = !isPassword;
            });
          },
        ),
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
      autocorrect: true,
    );
  }

  // Mot de passe oubié
  Widget _buildForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  TransitionFromCenterZoomOut(widget: const pageEmail()));
            },
            child: _buildGreyText("Mot de passe oublié ?")),
      ],
    );
  }

  //L bouton Login(Widgets)
  Widget _buildLoginButon() {
    return ElevatedButton(
        onPressed: () {
          signIn(
              emailController.text.trim(),
              passwordController.text.trim()
          );
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.blue,
          backgroundColor: Colors.blue,
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text("CONNECTER",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20)
        )
    );
  }
}
