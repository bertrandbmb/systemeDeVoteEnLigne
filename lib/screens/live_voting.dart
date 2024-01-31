import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoteDirectPage extends StatefulWidget {
  @override
  _VoteDirectPageState createState() => _VoteDirectPageState();
}

class _VoteDirectPageState extends State<VoteDirectPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  int nombreVotesMinimum = 1;
  int optionCount = 1;
  List<String> options = [];
  TextEditingController _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: const Text(
                    'Sondage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Titre du sondage',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ce champ ne peut pas être vide';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Description du sondage',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ce champ ne peut pas être vide';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    hintText: 'Entrez un code pour votre sondage \n  (au moins 12 caractères)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 12) {
                      return 'Le code doit comporter au moins 12 caractères \n   alphanumérique et sans espaces';
                    }
                    // Utilisation d'une expression régulière pour vérifier que la chaîne est alphanumérique et sans espaces
                    RegExp alphaNumeric = RegExp(r'^[a-zA-Z0-9]+$');
                    if (!alphaNumeric.hasMatch(value)) {
                      return 'Le code doit être alphanumérique et sans espaces';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Nombre de votes maximum \n par participant',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: '1',
                              decoration: const InputDecoration(
                                hintText: 'Min',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  nombreVotesMinimum = int.tryParse(value) ?? 1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Options',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (int j = 1; j <= optionCount; j++)
                        Row(
                          children: [
                            Text('$j. '),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Option $j',
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ce champ ne peut pas être vide';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    while (options.length < j) {
                                      options.add('');
                                    }
                                    options[j - 1] = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              removeOption();
                            },
                            style: ElevatedButton.styleFrom(primary: Colors.red),
                            child: const Text('- Option', style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              addOption();
                            },
                            style: ElevatedButton.styleFrom(primary: Colors.blue),
                            child: const Text('+ Option', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (context != null) {
                          Navigator.pop(context); // Annuler
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: const Text('Annuler', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        ajouterDocumentPersonnalise();
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: const Text('Lancer sondage', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addOption() {
    setState(() {
      optionCount++;
    });
  }

  void removeOption() {
    if (optionCount > 1) {
      setState(() {
        optionCount--;
      });
    }
  }

  void ajouterDocumentPersonnalise() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firebaseService.createVote(
          title: _titleController.text,
          description: _descriptionController.text,
          minVotes: nombreVotesMinimum,
          options: options,
          codeController: _codeController,
        );

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard_page',
              (route) => false,
        );
      } catch (e) {
        // Gérer les erreurs lors de l'ajout du vote à Firestore
        print('Erreur lors de l\'ajout du vote : $e');
      }
    }
  }
}

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createVote({
    required String title,
    required String description,
    required int minVotes,
    required List<String> options,
    required TextEditingController codeController,
  }) async {
    Map<String, dynamic> optionsMap = {};
    for (String option in options) {
      optionsMap[option] = {
        'idUsers': [],
        'voteCount': 0,
      };
    }
    String documentId = codeController.text;

    Map<String, dynamic> voteData = {
      'title': title,
      'description': description,
      'min_votes': minVotes,
      'options': optionsMap,
      'code': documentId,
    };

    await _firestore.collection('live_votes').doc(documentId).set(voteData);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoteDirect App',
      home: VoteDirectPage(),
    );
  }
}
