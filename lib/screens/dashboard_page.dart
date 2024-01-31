import 'package:flutter/material.dart';
import 'package:mypolling/screens/new_polling.dart';
import 'package:mypolling/screens/profil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "My Polling",
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.purple,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        primary: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 50,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Profil()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Commencer un vote",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Image.asset(
              "assets/images/img.png",
              width: 200,
              height: 200,
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              "Vote",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Center(
              child: ElevatedButton.icon(
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(10),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                  padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommencerScrutinPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 18,
                ),
                label: const Text(
                  "Créer un vote",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/liveVoteList');
                  },
                  child: const Text("Statistiques Votes En Direct"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/SondageProgramVoteList');
                    // Handle the action for "Statistiques Sondage"
                  },
                  child: const Text("Statistiques Sondage"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/VoteProgramElectionList');
                    // Handle the action for "Statistiques Election"
                  },
                  child: const Text("Statistiques Election"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
