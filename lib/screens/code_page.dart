import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mypolling/screens/new_password_page.dart';
import 'package:mypolling/screens/sign_up_page.dart';
import 'package:mypolling/screens/login_page.dart';
import 'package:mypolling/screens/transition_page.dart';


class CodeResetPage extends StatefulWidget {
  const CodeResetPage({super.key});

  @override
  State<CodeResetPage> createState() => _CodeResetPageState();
}

class _CodeResetPageState extends State<CodeResetPage> {
  late Size mediaSize;
  final formkey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();

  bool isResetCodeValid(String codeEntered, String codeStored) {
    return codeEntered == codeStored;
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
                    text: 'CONNEXION',
                    style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                            context,
                            TransitionFromCenterZoomIn(widget: const LoginPage())
                        );
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
                        Navigator.pushReplacement(
                            context,
                            TransitionFromCenterZoomIn(widget: const SignupPage())
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
        _buildGreyText("Code de réinitialisation"),
        _buildInputField(codeController),
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
          const codeStored='40';
          // codeStored =
          if(isResetCodeValid(codeController.text.trim(), codeStored)){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const NewPasswordPage()));
          }else{
            showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Text("Le code entré est erroné. Veuillez entrer le bon code"),
                    // actions: [
                    //   ElevatedButton(
                    //     onPressed: (){ },
                    //     child: Text("D'accord")
                    //   )
                    // ],
                  );
                }
            );
          }

        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.blue,
          backgroundColor: Colors.blue,
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text("RENINITIALISER",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20)));
  }

}