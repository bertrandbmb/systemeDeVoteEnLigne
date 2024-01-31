import 'package:flutter/material.dart';

import 'package:mypolling/screens/type_vote_program.dart';

class CommencerScrutinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Commencer un vote',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Image(
                image: AssetImage('assets/images/img.png'),
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Vote',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/vote_direct');
                },
                child: const Text('Vote en direct', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/type_vote_program');
                },
                child: const Text('Vote programmé', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
              ),
            ],
          ),
        ),
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
