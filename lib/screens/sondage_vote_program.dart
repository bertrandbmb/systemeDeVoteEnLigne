import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SondageVoteProgramPage extends StatefulWidget {
  @override
  _SondageVoteProgramPageState createState() => _SondageVoteProgramPageState();
}

class _SondageVoteProgramPageState extends State<SondageVoteProgramPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late DateTime _startDate;
  late DateTime _endDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  int nombreVotesMinimum = 1;
  int optionCount = 1;
  List<String> options = [];
  TextEditingController _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _startDate = DateTime.now();
    _endDate = DateTime.now().add(Duration(days: 7));
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
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

  String? validateDateAndTime() {
    DateTime startDate = DateTime(_startDate.year, _startDate.month, _startDate.day, _startTime.hour, _startTime.minute);
    DateTime endDate = DateTime(_endDate.year, _endDate.month, _endDate.day, _endTime.hour, _endTime.minute);

    if (endDate.isBefore(startDate)) {
      return 'La date et l\'heure de fin doivent être postérieures à la date et l\'heure de début';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  final FirebaseServiceSondage _firebaseServiceSondage = FirebaseServiceSondage();

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

                    //  espression régulière pour vérifier que la chaîne est alphanumérique et sans espaces
                    RegExp alphaNumeric = RegExp(r'^[a-zA-Z0-9]+$');
                    if (!alphaNumeric.hasMatch(value)) {
                      return 'Le code doit être alphanumérique et sans espaces';
                    }

                    return null;
                  },
                ),
                SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Début du sondage ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _startDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    _startDate = pickedDate;
                                  });
                                }
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: 'Date: ${DateFormat('dd/MM/yyyy').format(_startDate)}',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: _startTime,
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    _startTime = pickedTime;
                                  });
                                }
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: 'Heure: ${_startTime.format(context)}',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Fin du sondage ',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _endDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    _endDate = pickedDate;
                                  });
                                }
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: 'Date: ${DateFormat('dd/MM/yyyy').format(_endDate)}',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: _endTime,
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    _endTime = pickedTime;
                                  });
                                }
                              },
                              readOnly: true,
                              controller: TextEditingController(
                                text: 'Heure: ${_endTime.format(context)}',
                              ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Annuler
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: const Text('Annuler', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String? validationMessage = validateDateAndTime();
                        if (_formKey.currentState!.validate() && validationMessage == null) {
                          await _firebaseServiceSondage.createVote(_codeController.text, {
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'min_votes': nombreVotesMinimum,
                            'options': options,
                            'debut_election': DateTime(_startDate.year, _startDate.month, _startDate.day, _startTime.hour, _startTime.minute),
                            'fin_election': DateTime(_endDate.year, _endDate.month, _endDate.day, _endTime.hour, _endTime.minute),
                          });


                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/dashboard_page',
                                (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(validationMessage ?? 'Veuillez corriger les erreurs dans le formulaire'),
                          ));
                        }
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
}

class FirebaseServiceSondage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createVote(String code, Map<String, dynamic> voteData) async {
    DocumentSnapshot existingVote = await _firestore.collection('program_votes_sondage').doc(code).get();
    if (existingVote.exists) {
      print('Error: Document with the specified ID already exists.');
      return;
    }

    DateTime debutElection = DateTime(
      voteData['debut_election'].year,
      voteData['debut_election'].month,
      voteData['debut_election'].day,
      voteData['debut_election'].hour,
      voteData['debut_election'].minute,
    );

    DateTime finElection = DateTime(
      voteData['fin_election'].year,
      voteData['fin_election'].month,
      voteData['fin_election'].day,
      voteData['fin_election'].hour,
      voteData['fin_election'].minute,
    );

    voteData['debut_election'] = Timestamp.fromDate(debutElection);
    voteData['fin_election'] = Timestamp.fromDate(finElection);
    voteData['code'] = code;

    Map<String, dynamic> optionsMap = {};
    for (String option in voteData['options']) {
      optionsMap[option] = {
        'idUsers': [],
        'voteCount': 0,
      };
    }
    voteData['options'] = optionsMap;
    await _firestore.collection('program_votes_sondage').doc(code).set(voteData);
  }

  Future<QuerySnapshot> getVotesWithCode(String code) async {
    return await _firestore.collection('program_votes_sondage').where('code', isEqualTo: code).get();
  }
}
