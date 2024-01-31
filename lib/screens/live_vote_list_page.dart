import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'live_vote_details_page.dart';

class LiveVoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Sondages en Direct'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Bienvenue dans la Liste des Sondages en direct',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Cliquez sur un sondage pour voir les statistiques ou voter.',
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('live_votes')
                  .snapshots(),
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

                    return Card(
                      elevation: 3.0,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Text(
                          'Titre: ${voteData?['title'] ?? ''}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            'Description: ${voteData?['description'] ?? ''}'),
                        onTap: () {
                          _showCodeInputDialog(context, voteId!);
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

  _verifyCodeAndNavigate(BuildContext context, String voteId,
      String enteredCode) {
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
