import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VoteProgramElectionDetails extends StatelessWidget {
  final String voteId;

  VoteProgramElectionDetails(this.voteId);

  Future<void> submitVote(User? user, BuildContext context) async {
    if (user == null) {
      print('Utilisateur non authentifié');
      return;
    }

    final voteDoc = FirebaseFirestore.instance.collection('program_votes_election').doc(voteId);

    try {
      var voteSnapshot = await voteDoc.get();
      var voteData = voteSnapshot.data();

      if (voteData == null) {
        print('Données du vote non disponibles');
        return;
      }

      var userVoted = voteData['idUsers']?.contains(user.uid) ?? false;
      if (userVoted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vous avez déjà voté pour cette élection.'),
          ),
        );
        return;
      }

      Timestamp endDate = voteData['fin_election'];
      DateTime endDateTime = endDate.toDate();
      DateTime currentDateTime = DateTime.now();

      if (currentDateTime.isAfter(endDateTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('La date de fin de l\'élection est dépassée. Vous ne pouvez plus voter.'),
          ),
        );
        return;
      }

      await voteDoc.update({
        'idUsers': FieldValue.arrayUnion([user.uid]),
        'candidats.Candidate1.idUsers': FieldValue.arrayUnion([user.uid]), // Replace "Candidate1" with the actual candidate you are referring to
        'candidats.Candidate1.voteCount': FieldValue.increment(1), // Replace "Candidate1" with the actual candidate you are referring to
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
        stream: FirebaseFirestore.instance.collection('program_votes_election').doc(voteId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            print('No data available');
            return Center(child: Text('Aucune donnée disponible'));
          }

          var voteData = snapshot.data?.data();
          print('VoteData: $voteData');

          var title = voteData?['title'] ?? '';
          var description = voteData?['description'] ?? '';
          var candidats = voteData?['candidats'] as Map<String, dynamic>?;

          if (candidats == null || candidats.isEmpty) {
            print('No candidats data available');
            return Center(child: Text('Aucune donnée sur les candidats disponible'));
          }

          var candidate1 = candidats['Candidate1'] as Map<String, dynamic>?;

          if (candidate1 == null || candidate1.isEmpty) {
            print('No data for Candidate1 available');
            return Center(child: Text('Aucune donnée pour le candidat 1 disponible'));
          }

          var voteCount = candidate1['voteCount'] ?? '';

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title: $title',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Description: $description',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 8.0),

                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    User? user = FirebaseAuth.instance.currentUser;
                    submitVote(user, context);
                  },
                  child: Text('Voter'),
                ),
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