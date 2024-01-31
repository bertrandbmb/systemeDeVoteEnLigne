import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'live_vote_details_page.dart';

class SondageProgramVoteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Sondages'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bienvenue dans la Liste des sondages',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Cliquez sur un vote pour voir les statistiques ou voter.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('program_votes_sondage').snapshots(),
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
                    var debutElectionTimestamp = voteData?['debut_election'] as Timestamp;
                    var finElectionTimestamp = voteData?['fin_election'] as Timestamp;

                    var debutElectionDate = debutElectionTimestamp.toDate();
                    var finElectionDate = finElectionTimestamp.toDate();

                    var surveyStatus = calculateSurveyStatus(debutElectionDate, finElectionDate);

                    return Card(
                      elevation: 3.0,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(
                          'Titre: ${voteData?['title'] ?? ''}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description: ${voteData?['description'] ?? ''}'),
                            Text('Début: $debutElectionDate'),
                            Text('Fin: $finElectionDate'),
                            Text('Statut: $surveyStatus'),
                          ],
                        ),
                        onTap: () {
                          if (DateTime.now().isAfter(debutElectionDate)) {
                            _showCodeInputDialog(context, voteId!);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Le sondage n\'a pas encore débuté.'),
                              ),
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

  String calculateSurveyStatus(DateTime debutElection, DateTime finElection) {
    var currentTime = DateTime.now();

    if (currentTime.isBefore(debutElection)) {
      var timeRemaining = debutElection.difference(currentTime);
      return 'Temps restant pour le début du sondage : ${timeRemaining.inHours} heures ${timeRemaining.inMinutes.remainder(60)} minutes';
    } else if (currentTime.isBefore(finElection)) {
      return 'Sondage en cours';
    } else {
      return 'Sondage terminé';
    }
  }

  _showCodeInputDialog(BuildContext context, String voteId) async {
    TextEditingController codeController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Entrez le code du sondage'),
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
