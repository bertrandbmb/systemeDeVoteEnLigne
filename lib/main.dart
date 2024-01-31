import 'package:flutter/material.dart';
import 'package:mypolling/screens/about_page.dart';
import 'package:mypolling/screens/dashboard_page.dart';
import 'package:mypolling/screens/election_vote_program.dart';
import 'package:mypolling/screens/live_voting.dart';
import 'package:mypolling/screens/login_page.dart';
import 'package:mypolling/screens/new_polling.dart';
import 'package:mypolling/screens/profil.dart';
import 'package:mypolling/screens/sign_up_page.dart';
import 'package:mypolling/screens/sondage_vote_program.dart';
import 'package:mypolling/screens/start_page.dart';
import 'package:mypolling/screens/type_vote_program.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:mypolling/screens/live_vote_details_page.dart';
import 'package:mypolling/screens/live_vote_list_page.dart';
import 'package:mypolling/screens/election_vote_program_details.dart';
import 'package:mypolling/screens/election_vote_program_list.dart';
import 'package:mypolling/screens/sondage_vote_program_details.dart';
import 'package:mypolling/screens/sondage_vote_program_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon Application Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Start(),
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/sign_up_page': (context) => const SignupPage(),
        '/dashboard_page': (context) => const HomePage(),
        '/profil_page': (context) => const Profil(),
        '/liveVoteList': (context) => LiveVoteListPage(),
        '/liveVoteDetails': (context) {
          final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          final String voteId = args['voteId'] as String;
          return LiveVoteDetailsPage(voteId);
        },
        '/VoteProgramElectionList': (context) => VoteProgramElectionList(),
        '/VoteProgramElectionDetails': (context) {
          final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          final String voteId = args['voteId'] as String;
          return VoteProgramElectionDetails(voteId);
        },
        '/SondageProgramVoteList': (context) => SondageProgramVoteList(),
        '/SondageProgramVoteDetails': (context) {
          final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          final String voteId = args['voteId'] as String;
          return SondageProgramVoteDetails(voteId);
        },



        '/commencer_scrutin': (context) => CommencerScrutinPage(),
        '/vote_direct': (context) => VoteDirectPage(),
        '/type_vote_program': (context) => TypeVoteProgramPage(),
        '/sondage_vote_program': (context) => SondageVoteProgramPage(),
        '/election_vote_program': (context) => ElectionVoteProgramPage(),

      },
    );
  }
}
