import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mypolling/screens/login_page.dart';
import 'package:mypolling/screens/transition_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late Size mediaSize;
  bool isPassword = true;
  bool isSigningUp = false;

  RegExp emailRegex = RegExp(r'^[a-zA-Z]+([0-9])*@[a-zA-Z]+.[a-zA-Z]{2,7}$');
  RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$ù.%^&*()\-_=+{};:,<.>])(?=.*[^\s]).{8,}$');

  final formkey = GlobalKey<FormState>();

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    nomController.dispose();
    prenomController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> signUp(String email, String password, String nom, String prenom) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateProfile(
        displayName: '$nom $prenom',
      );
      const CircleAvatar(backgroundColor: Colors.blue);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inscription réussie", style: TextStyle(color: Colors.yellow), textAlign: TextAlign.center,)),
      );
      // Naigue vers la page d'accueil après l'inscription réussie
      Navigator.push(
          context,
          TransitionFromLeft(widget: const LoginPage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de l'inscription: ${e.toString()}", style: const TextStyle(color: Colors.yellow))),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Positioned(top: 5, child: _buildTop()),
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

  Widget _buildBottom1() {
    return SizedBox(
      width: mediaSize.width,
      height: 710,
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
                        Navigator.push(context,
                            TransitionFromLeft(widget: const LoginPage()));
                      },
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "INSCRIPTION",
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

  Widget _buildForm({required GlobalKey<FormState> key}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pour le texte "Nom", utilisez MainAxisAlignment.center
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildGreyText("Nom"),
                  ],
                ),
                _buildInputField(nomController),
                const SizedBox(height: 14),

                // Pour les autres champs, utilisez MainAxisAlignment.start
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildGreyText("Prenom"),
                  ],
                ),
                _buildInputField(prenomController),
                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildGreyText("Email"),
                  ],
                ),
                _buildInputField(emailController),
                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildGreyText("Mot de passe"),
                  ],
                ),
                _buildInputFieldPassword(passwordController),
                const SizedBox(height: 14),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildGreyText("Confirmer le mot de passe"),
                  ],
                ),
                _buildInputFieldPassword(confirmPasswordController),
                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildLoginButon(),
                    _buildLoginButon1(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Widget _buildInputFieldPassword(TextEditingController controller) {
    return TextFormField(
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Ce champ ne peut pas être vide";
          }
          if (value.length < 8) {
            return "Ce champs doit contenir au moins 8 caractères";
          }
          if((!passwordRegex.hasMatch(passwordController.text)) && (controller == passwordController)){
            return "Le mot de passe doit contenir au moins une majuscule, une minuscule, un chiffre, un caractère spéciale et au moins 8 caractères en tout";
          }
          if((!passwordRegex.hasMatch(confirmPasswordController.text)) && (controller == confirmPasswordController)){
            return "Le mot de passe doit contenir au moins une majuscule, une minuscule, un chiffre, un caractère spéciale et au moins 8 caractères en tout";
          }
          if (controller == passwordController &&
              value != confirmPasswordController.text) {
            return "Les mots de passe ne correspondent pas";
          }
          if (controller == confirmPasswordController &&
              value != passwordController.text) {
            return "Les mots de passe ne correspondent pas";
          }
          return null;
        }
    );
  }

  Widget _buildInputField(TextEditingController controller) {
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
          if (value == null || value.isEmpty) {
            return "Ce champ ne peut pas être vide";
          }
          if (value.length < 3) {
            return "Ce champs doit contenir au moins 3 caractères";
          }
          if((!emailRegex.hasMatch(emailController.text)) && (controller == emailController)){
            return "Le format de l'email n'est pas respecté";
          }

          return null;
        }
    );
  }

  Widget _buildLoginButon() {
    return ElevatedButton(
        onPressed: () {
          nomController.clear();
          prenomController.clear();
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.redAccent,
          backgroundColor: Colors.red,
          minimumSize: const Size(90, 50),
        ),
        child: const Text("EFFACER",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16)));
  }

  Widget _buildLoginButon1() {
    return ElevatedButton(
        onPressed: () async {
          if (formkey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Envoi en cours ...")),
            );

            FocusScope.of(context).requestFocus(FocusNode());

            final snapshot = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailController.text);
            const CircularNotchedRectangle();
            if (snapshot.isNotEmpty) {
              // L'email est déjà utilisé.
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text("Cet email est déjà utilisé. Nous vous prions de remplir correctement les informations", style: TextStyle(fontSize: 20),),
                    );
                  }
              );

            } else {
              signUp(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                  nomController.text.trim(),
                  prenomController.text.trim()
              );
            }
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.blue,
          backgroundColor: Colors.blue,
          minimumSize: const Size(90, 50),
        ),
        child: const Text("S'INSCRIRE",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16)));
  }
}

