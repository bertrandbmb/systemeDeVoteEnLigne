import 'package:flutter/material.dart';

class TransitionFromRight extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromRight({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
            position: animation.drive(tween),
            child: child
        );
      }
  );
}

class TransitionFromLeft extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromLeft({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
            position: animation.drive(tween),
            child: child
        );
      }
  );
}

class TransitionFromTop extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromTop({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        var begin = const Offset(0.0, -1.0);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
            position: animation.drive(tween),
            child: child
        );
      }
  );
}

class TransitionFromButtom extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromButtom({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
            position: animation.drive(tween),
            child: child
        );
      }
  );
}

class TransitionFromButtomRight extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromButtomRight({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        return AnimatedBuilder(
          animation: animation,
          // ignore: non_constant_identifier_names
          builder: (BuildContext context, Widgetchild) {
            return Stack(
                children: <Widget>[
                  Positioned(
                      top: MediaQuery.of(context).size.height * (1 - animation.value),
                      left: MediaQuery.of(context).size.width * (1 - animation.value),
                      width: MediaQuery.of(context).size.width * animation.value,
                      height: MediaQuery.of(context).size.height * animation.value,
                      child: Opacity(
                        opacity: animation.value,
                        child: child,
                      )
                  ),
                ]
            );
          },
          child: child,
        );
      }
  );
}

class TransitionFromCenterZoomOut extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromCenterZoomOut({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        var begin = 0.1;
        var end = 1.0;
        var curve = Curves.fastOutSlowIn;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
            scale: animation.drive(tween),
            child: child
        );
      }
  );
}

class TransitionFromButtomZoomOut extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromButtomZoomOut({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        return SlideTransition(
          position: Tween<Offset> (
              begin: const Offset(0, 1),
              end: Offset.zero
          ).animate(
            CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.5,
              end: 1,
            ).animate(
              CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn
              ),
            ),
            child: child,
          ),
        );
      }
  );
}

class TransitionFromButtomZoomIn extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromButtomZoomIn({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        return SlideTransition(
          position: Tween<Offset> (
              begin: const Offset(0, 1),
              end: Offset.zero
          ).animate(
            CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn
            ),
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 2.0,
              end: 1,
            ).animate(
              CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn
              ),
            ),
            child: child,
          ),
        );
      }
  );
}

class TransitionFromCenterZoomIn extends PageRouteBuilder{
  late final Widget widget;

  TransitionFromCenterZoomIn({required this.widget}) : super(
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {

        var begin = 2.0;
        var end = 1.0;
        var curve = Curves.fastOutSlowIn;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(
            scale: animation.drive(tween),
            child: child
        );
      }
  );
}