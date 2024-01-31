import 'package:flutter/material.dart';
import 'sondage_vote_program.dart';
import 'election_vote_program.dart';


class TypeVoteProgramPage extends StatefulWidget {
  @override
  _TypeVoteProgramPageState createState() => _TypeVoteProgramPageState();
}

class _TypeVoteProgramPageState extends State<TypeVoteProgramPage> {
  String _selectedType = 'Sondage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
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
                child: Text(
                  'Choisissez le type de vote',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              RadioListTile<String>(
                title: Text('Sondage'),
                value: 'Sondage',
                groupValue: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Élection'),
                value: 'Élection',
                groupValue: _selectedType,
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Précédent
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text('Annuler',style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Suivant
                      // Navigation conditionnelle en fonction du type sélectionné
                      if (_selectedType == 'Sondage') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SondageVoteProgramPage()),
                        );
                      } else if (_selectedType == 'Élection') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ElectionVoteProgramPage()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text('Suivant',style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
