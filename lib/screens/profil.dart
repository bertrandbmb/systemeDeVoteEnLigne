import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './login_page.dart';
import './transition_page.dart';
import './edit_profil.dart';
import './about_page.dart';


class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  late String nom;
  late String prenom;

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() {
    // Récupération du nom et du prénom
    List<String>? nameParts = user!.displayName?.split(' ');
    nom = nameParts![0];
    prenom = nameParts[1];
  }

  // Fonction de déconnection
  Future<void> signOut() async {
    await _auth.signOut();

    Navigator.pushAndRemoveUntil(
        context,
        TransitionFromTop(widget: const LoginPage()),
            (Route<dynamic> route) => false
    );

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous êtes maintenant déconnecté'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text("My Polling", style: TextStyle(fontStyle:
            FontStyle.italic, color: Colors.blue/*white*/, fontWeight: FontWeight.w600, fontSize: 30),),
            backgroundColor: const Color.fromARGB(255, 2, 49, 56),
            actions: [
              Container(
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 2, 49, 56),
                    border: Border.all(color: const Color(0xFF0079FF)),
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        TransitionFromButtom(widget: const Profil()),
                      );
                    },
                  )
              ),
            ]
        ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  color: const Color.fromARGB(255, 2, 49, 56),
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 2, 49, 56),
                            border: Border.all(color: const Color(0xFF0079FF)),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: const Icon(Icons.person, color: Colors.blue, size: 90,),
                        ),
                        // const SizedBox(width: 50,),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text("${nom.toUpperCase()}\n$prenom", style: const TextStyle(color: Colors.yellow, fontSize: 20, letterSpacing: 3), textAlign: TextAlign.right,),
                        ),

                      ]
                  ),
                ),
                const SizedBox(height: 3,),

                Container(
                  height: 2,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.75),
                ),

                const SizedBox(height: 10,),
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 50,),
                    child: Column(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFF36A9E1)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              padding: MaterialStateProperty.all(const EdgeInsets.only(left: 90, right: 90)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  TransitionFromButtomZoomIn(widget: const EditProfil()));
                            },
                            child: const Text("Editer profil", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)
                        ),
                        const SizedBox(height: 20,),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFF36A9E1)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              padding: MaterialStateProperty.all(const EdgeInsets.only(left: 100, right: 100)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  TransitionFromButtomZoomIn(widget: const AboutMyPolling()));
                            },
                            child: const Text("A propos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)
                        ),
                        const SizedBox(height: 20,),
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0xFF36A9E1)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              padding: MaterialStateProperty.all(const EdgeInsets.only(left: 70, right: 70)),
                            ),
                            onPressed: () {
                              signOut();
                            },
                            child: const Text("Se déconnecter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),)
                        )
                      ],
                    )
                )
              ]
          ),
        )
    );
  }
}
