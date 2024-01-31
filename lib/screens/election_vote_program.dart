import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ElectionVoteProgramPage extends StatefulWidget {
  @override
  _ElectionVoteProgramPageState createState() => _ElectionVoteProgramPageState();
}

class _ElectionVoteProgramPageState extends State<ElectionVoteProgramPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  late DateTime _startDate;
  late DateTime _endDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  int optionCount = 1;
  List<String> candidats = [];

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
    if (_endDate.isBefore(_startDate) ||
        (_endDate.isAtSameMomentAs(_startDate) &&
            (_endTime.hour < _startTime.hour ||
                (_endTime.hour == _startTime.hour &&
                    _endTime.minute < _startTime.minute)))) {
      return 'La date et l\'heure \n de fin doivent être \n postérieures à la \n date et l\'heure de début';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();
  final FirebaseServiceElection _firebaseServiceElection = FirebaseServiceElection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Election',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'Titre ',
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
                    hintText: 'Description de l\'election',
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
                    hintText: 'Entrez un code pour votre election \n  (au moins 12 caractères)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.length < 12) {
                      return 'Le code doit comporter au moins 12 caractères \n   alphanumérique et sans espaces';
                    }

                    // Utilisation d'une expression reguliere pour verifier que la chaîne est alphanumeriique et sans espaces
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
                      const Text(
                        'Début de l\'élection ',
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
                                  initialDate: DateTime.now(),
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
                                  initialTime: TimeOfDay.now(),
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
                        'Fin de l\'élection ',
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
                                  initialDate: DateTime.now(),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ce champ ne peut pas être vide';
                                }
                                return validateDateAndTime();
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ce champ ne peut pas être vide';
                                }
                                return validateDateAndTime();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                        'Candidats',
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
                                  hintText: 'Candidat $j',
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
                                    while (candidats.length < j) {
                                      candidats.add('');
                                    }
                                    candidats[j - 1] = value;
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
                            child: const Text('- Candidats', style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              addOption();
                            },
                            style: ElevatedButton.styleFrom(primary: Colors.blue),
                            child: const Text('+ Candidats', style: TextStyle(color: Colors.white)),
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
                        Navigator.pop(context); // Precedent
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: const Text('Precedent', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _firebaseServiceElection.createVote({
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'debut_election': DateTime(_startDate.year, _startDate.month, _startDate.day, _startTime.hour, _startTime.minute),
                            'fin_election': DateTime(_endDate.year, _endDate.month, _endDate.day, _endTime.hour, _endTime.minute),
                            'candidats': candidats,
                            'code': _codeController.text,
                          });
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/dashboard_page',
                                (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: const Text('Lancer election', style: TextStyle(color: Colors.white)),
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

class FirebaseServiceElection {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createVote(Map<String, dynamic> voteData) async {
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

    // Remplacer les valeurs dans le map par les Timestamps correspondants
    voteData['debut_election'] = Timestamp.fromDate(debutElection);
    voteData['fin_election'] = Timestamp.fromDate(finElection);

    Map<String, dynamic> candidatsMap = {};
    for (String candidat in voteData['candidats']) {
      candidatsMap[candidat] = {
        'idUsers': [],
        'voteCount': 0,
      };
    }

    // Remplacez la liste d'options dans voteData par la nouvelle map
    voteData['candidats'] = candidatsMap;
    // Utilisez le code comme ID de document
    String code = voteData['code'];
    await _firestore.collection('program_votes_election').doc(code).set(voteData);
  }
}
