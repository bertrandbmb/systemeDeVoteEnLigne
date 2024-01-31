import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard_page.dart';
import './transition_page.dart';
import './profil.dart';

class EditProfil extends StatefulWidget {
  const EditProfil({super.key});

  @override
  State<EditProfil> createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  late String nom;
  late String prenom;

  @override
  void initState() {
    super.initState();

    getName();
  }

  void getName() {
    List<String>? nameParts = user!.displayName?.split(' ');
    nom = nameParts![0];
    prenom = nameParts[1];
  }

  @override
  void dispose(){
    super.dispose();

    nomController.dispose();
    prenomController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

            centerTitle: true,

            title: const Text("MyPolling", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blue/*white*/, fontWeight: FontWeight.bold),),
            backgroundColor: const Color.fromARGB(255, 2, 49, 56),

            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: 35, color: Colors.white,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
          // color: Colors.white,
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

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 2.0,
                              offset: Offset(2, 5),
                              spreadRadius: 10.0
                          )
                        ],
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      ),
                      child: Column(
                        children: [

                          Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  const Padding(padding: EdgeInsets.only(top: 15)),

                                  const Text("Modifier mon profil", style: TextStyle(color: Colors.blue, fontSize: 18),),

                                  const Padding(padding: EdgeInsets.only(top: 15)),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      controller: nomController,
                                      // initialValue: nom.toUpperCase(),
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.person, color: Colors.blue,),
                                        labelText: " Nom ",
                                        hintText: nom.toUpperCase(),
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
                                        if(value.length < 3){
                                          return "Le nom doit contenir au moins 3 caractères";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  const Padding(padding: EdgeInsets.only(top: 15)),

                                ],
                              )
                          ),

                          const Padding(padding: EdgeInsets.only(top: 15)),

                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: prenomController,
                              // initialValue: prenom,
                              decoration: InputDecoration(
                                icon: const Icon(Icons.person, color: Colors.blue,),
                                labelText: " Prénom ",
                                hintText: prenom,
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
                                if(value.length < 3){
                                  return "Le prénom doit contenir au moins 3 caractères";
                                }
                                return null;
                              },
                            ),
                          ),

                          const Padding(padding: EdgeInsets.only(top: 15)),

                        ],
                      )
                  ),

                  const Padding(padding: EdgeInsets.only(top: 15)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          nomController.clear();
                          prenomController.clear();
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          elevation: MaterialStatePropertyAll(10),
                        ),
                        child: const Text("REINITIALISER", style: TextStyle(color: Colors.white),),
                      ),

                      ElevatedButton(
                        onPressed: () async {
                          if(formkey.currentState!.validate()){

                            FocusScope.of(context).requestFocus(FocusNode());

                            const CircularProgressIndicator(backgroundColor: Colors.blue,);

                            // Mettre à jour les informations de l'utilisateur
                            await user?.updateDisplayName('${nomController.text} ${prenomController.text}');

                            const CircularProgressIndicator(backgroundColor: Colors.blue,);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Informations modifiées avec succès", style: TextStyle(color: Colors.yellow), textAlign: TextAlign.center,)),
                            );

                            // Redirection
                            Navigator.pushReplacement(
                                context,
                                TransitionFromCenterZoomOut(widget: const Profil())
                            );

                          }

                        },

                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.blue),
                          elevation: MaterialStatePropertyAll(10),
                        ),
                        child: const Text("MODIFIER", style: TextStyle(color: Colors.white),),
                      ),

                    ],
                  ),

                  const Padding(padding: EdgeInsets.only(top: 15)),

                  Positioned(
                    bottom: 0,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage())
                          );
                        },
                        child: const Text("Aller au dashboard", style: TextStyle(color: Colors.blue, fontSize: 18),)
                    ),
                  ),

                  const SizedBox(height: 10,),

                ]
            )
        )

    );

  }
}

class MyName{
  late User user;
  late String nom;
  late String prenom;

  void initUser() {
    user = FirebaseAuth.instance.currentUser!;

    // Récupération du nom et du prénom
    List<String> nameParts = user.displayName?.split(' ') ?? [];
    nom = nameParts.isNotEmpty ? nameParts[0] : '';
    prenom = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

  }
}