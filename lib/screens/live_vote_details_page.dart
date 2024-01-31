import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LiveVoteDetailsPage extends StatelessWidget {
  final String voteId;

  LiveVoteDetailsPage(this.voteId);

  Future<void> submitVote(String optionId, User? user, BuildContext context) async {
    if (user == null) {
      print('Utilisateur non authentifié');
      return;
    }

    final voteDoc = FirebaseFirestore.instance.collection('live_votes').doc(voteId);

    try {
      var voteSnapshot = await voteDoc.get();
      var voteData = voteSnapshot.data();
      if (voteData == null) {
        print('Données du vote non disponibles');
        return;
      }

      var options = voteData['options'] as Map<String, dynamic>?;
      if (options == null) {
        print('Options du vote non disponibles');
        return;
      }

      var minVotes = voteData['min_votes'] ?? 0;
      var userVotes = options[optionId]?['idUsers']?.length ?? 0;

      if (userVotes >= minVotes) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vous avez atteint le nombre maximal de votes pour cette option.'),
          ),
        );
        return;
      }

      await voteDoc.update({
        'options.$optionId.idUsers': FieldValue.arrayUnion([user.uid]),
        'options.$optionId.voteCount': FieldValue.increment(1),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vote enregistré avec succès!'),
        ),
      );
    } catch (error) {
      print('Erreur lors de l\'enregistrement du vote: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails du Vote'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('live_votes').doc(voteId).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var voteData = snapshot.data?.data();
          if (voteData == null) {
            return Center(
              child: Text('Aucune donnée disponible'),
            );
          }

          var options = voteData['options'] as Map<String, dynamic>?;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title: ${voteData['title'] ?? ''}',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Description: ${voteData['description'] ?? ''}',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Nombre de vote minimum: ${voteData['min_votes'] ?? ''}',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                if (options != null)
                  for (var optionId in options.keys) ...[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          'Option $optionId',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Nombres de votes: ${options[optionId]?['voteCount'] ?? 0}',
                        ),
                        trailing: ElevatedButton.icon(
                          onPressed: () {
                            User? user = FirebaseAuth.instance.currentUser;
                            submitVote(optionId, user, context);
                          },
                          icon: Icon(Icons.thumb_up),
                          label: Text('Voter'),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(16.0),
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
}
