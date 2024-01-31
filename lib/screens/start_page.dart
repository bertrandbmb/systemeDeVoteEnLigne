import 'package:flutter/material.dart';
import 'package:mypolling/screens/guide_vote.dart';
import 'package:mypolling/screens/login_page.dart';
import 'package:mypolling/screens/transition_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animationLogo;
  static bool _isNewUser = true;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _animationLogo = Tween<double>(
        begin: 0,
        end: 1
    ).animate(_animationController);

    _redirigerVersPagePrincipale();

  }


  _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isNewUser = prefs.getBool('isFirstTime') ?? true;

    setState(() {
      _isNewUser = isNewUser;
    });
  }

  _setFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  _redirigerVersPagePrincipale() {
    Future.delayed(const Duration(seconds: 2), () {
      _checkFirstTime();
      Navigator.pushReplacement(
        context,
        TransitionFromCenterZoomIn(widget: (_isNewUser) ? const GuidePage() : const LoginPage()),
      );
      _setFirstTime();
    });
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationLogo,
        builder: (context, child){
          return Opacity(
            opacity: _animationLogo.value,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Image(
                image: AssetImage('assets/images/start.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),

    );
  }
}