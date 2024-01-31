import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'live_vote_details_page.dart';

class VoteProgramElectionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Election'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bienvenue dans la Liste des Election',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Cliquez sur une election pour voir les statistiques ou voter.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('program_votes_election').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var votesData = snapshot.data?.docs;

                return ListView.builder(
                  itemCount: votesData?.length,
                  itemBuilder: (context, index) {
                    var voteData = votesData?[index].data();
                    var voteId = votesData?[index].id;

                    // Convertir les timestamps en objets DateTime
                    DateTime debutElection = (voteData?['debut_election'] as Timestamp?)?.toDate() ?? DateTime.now();
                    DateTime finElection = (voteData?['fin_election'] as Timestamp?)?.toDate() ?? DateTime.now();

                    // Récupérer la date et l'heure actuelles
                    DateTime now = DateTime.now();

                    // Vérifier le statut de l'élection
                    String status;
                    if (now.isBefore(debutElection)) {
                      // L'élection n'a pas encore commencé
                      status = 'Début dans ${formatDuration(debutElection.difference(now))}';
                    } else if (now.isBefore(finElection)) {
                      // L'élection est en cours
                      status = 'En cours';
                    } else {
                      // L'élection est terminée
                      status = 'Terminée';
                    }

                    return Card(
                      elevation: 3.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(
                          'Titre: ${voteData?['title'] ?? ''}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description: ${voteData?['description'] ?? ''}'),
                            Text('Début: $debutElection'),
                            Text('Statut: $status'),
                            if (now.isBefore(finElection))
                              Text('Fin: ${formatDate(finElection)}'),
                          ],
                        ),
                        onTap: () {
                          if (now.isAfter(debutElection)) {
                            // La date de début de l'élection a été atteinte, afficher la boîte de dialogue du code
                            _showCodeInputDialog(context, voteId!);
                          } else {
                            // La date de début de l'élection n'a pas été atteinte, afficher un message
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Élection pas encore commencée'),
                                  content: Text('L\'élection n\'a pas encore commencé. Veuillez patienter.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/dashboard_page',
                    (route) => false,
              );
            },
            child: Text('Retour'),
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  String formatDuration(Duration duration) {
    return '${duration.inHours}h ${duration.inMinutes.remainder(60)}min';
  }

  _showCodeInputDialog(BuildContext context, String voteId) async {
    TextEditingController codeController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Entrez le code de l election'),
          content: TextField(
            controller: codeController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                _verifyCodeAndNavigate(context, voteId, codeController.text);
              },
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }
  _verifyCodeAndNavigate(BuildContext context, String voteId, String enteredCode) {
    if (enteredCode == voteId) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LiveVoteDetailsPage(voteId),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Code incorrect'),
            content: Text('Veuillez entrer un code valide.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
