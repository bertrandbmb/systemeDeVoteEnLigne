import 'package:flutter/material.dart';
import 'package:mypolling/screens/dashboard_page.dart';
import 'package:mypolling/screens/transition_page.dart';

class AboutMyPolling extends StatefulWidget {
  const AboutMyPolling({super.key});

  @override
  State<AboutMyPolling> createState() => _AboutMyPollingState();
}

class _AboutMyPollingState extends State<AboutMyPolling>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _animationText;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 600),
    )..forward();

    final animationCurve =
    CurvedAnimation(parent: _animationController, curve: Curves.linear);

    _animationText = Tween<Offset>(
        begin: const Offset(0.0, -0.5), end: const Offset(0.0, -2.0))
        .animate(animationCurve);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "MyPolling",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.blue /*white*/,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned(
                child: SingleChildScrollView(
                  child: SlideTransition(
                    position: _animationText,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "MYPOLLING",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "MyPolling est une application de vote en ligne instantanée qui vous permet de mettre en place non seulement des scrutins mais également de créer une éléction et d'assurer leur suivi. Avec MyPolling, les votes sont organisés en sondage et en élection.Vous pouvez programmé un vote qui se lancera automatiquement le moment venu ou créer et lancer sur place votre vote. Avec MyPolling, vous décidez de qui pourra voter grâce à notre système d'envoi d'invitation de vote.",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "DESIGN",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "GBENOU Mardochée\nTOHOUESSOU J. Jean",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "FRONTEND",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nGBENOU Mardochée\nBOGNINOU Bertrand\nTOUMOUDAGOU D. Eric\nSOSSOU Nelson\nAZANHOUM Fiacre\nTOHOUESSOU J. Jean",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "BACKEND",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nBOGNINOU Bertrand\nTOUMOUDAGOU D. Eric",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "CAHIER DES CHARGES",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nTOUMOUDAGOU D. Eric\nTOUHOESSOU J. Jean\nBOGNINOU Bertrand\nAZANHOUN Fiacre",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "REMERCIEMENTS",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DHOSSOU Ephrem",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "SOUS L'INITIATIVE DE",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "M. Eric ADJE",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "TP FLUTTER 2023-2024\n\nGROUPE 11",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.dotted),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "MYPOLLING",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "MyPolling est une application de vote en ligne instantanée qui vous permet de mettre en place non seulement des scrutins mais également de créer une éléction et d'assurer leur suivi. Avec MyPolling, les votes sont organisés en sondage et en élection.Vous pouvez programmé un vote qui se lancera automatiquement le moment venu ou créer et lancer sur place votre vote. Avec MyPolling, vous décidez de qui pourra voter grâce à notre système d'envoi d'invitation de vote.",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "DESIGN",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "GBENOU Mardochée\nTOHOUESSOU J. Jean",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "FRONTEND",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nGBENOU Mardochée\nBOGNINOU Bertrand\nTOUMOUDAGOU D. Eric\nSOSSOU Nelson\nAZANHOUM Fiacre\nTOHOUESSOU J. Jean",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "BACKEND",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nBOGNINOU Bertrand\nTOUMOUDAGOU D. Eric",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "CAHIER DES CHARGES",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nTOUMOUDAGOU D. Eric\nTOUHOESSOU J. Jean\nBOGNINOU Bertrand\nAZANHOUN Fiacre",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "REMERCIEMENTS",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DHOSSOU Ephrem",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "SOUS L'INITIATIVE DE",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "M. Eric ADJE",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "TP FLUTTER 2023-2024\n\nGROUPE 11",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.dotted),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "MYPOLLING",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "MyPolling est une application de vote en ligne instantanée qui vous permet de mettre en place non seulement des scrutins mais également de créer une éléction et d'assurer leur suivi. Avec MyPolling, les votes sont organisés en sondage et en élection.Vous pouvez programmé un vote qui se lancera automatiquement le moment venu ou créer et lancer sur place votre vote. Avec MyPolling, vous décidez de qui pourra voter grâce à notre système d'envoi d'invitation de vote.",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "DESIGN",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "GBENOU Mardochée\nTOHOUESSOU J. Jean",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "FRONTEND",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nGBENOU Mardochée\nBOGNINOU Bertrand\nTOUMOUDAGOU D. Eric\nSOSSOU Nelson\nAZANHOUM Fiacre\nTOHOUESSOU J. Jean",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "BACKEND",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nBOGNINOU Bertrand\nTOUMOUDAGOU D. Eric",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "CAHIER DES CHARGES",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DANSOU Roméo\nTOUMOUDAGOU D. Eric\nTOUHOESSOU J. Jean\nBOGNINOU Bertrand\nAZANHOUN Fiacre",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "REMERCIEMENTS",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "DHOSSOU Ephrem",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "SOUS L'INITIATIVE DE",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 25,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.solid),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text(
                            "M. Eric ADJE",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.only(top: 20)),
                          Text(
                            "TP FLUTTER 2023-2024\n\nGROUPE 11",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationStyle: TextDecorationStyle.dotted),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, TransitionFromLeft(widget: const HomePage()));
        },
        tooltip: "Allez au dashboard",
        elevation: 15,
        backgroundColor: Colors.blue,
        child: IconButton(
          icon: const Icon(Icons.home),
          color: Colors.white,
          onPressed: () {
            Navigator.push(
                context, TransitionFromButtomRight(widget: const HomePage()));
          },
        ),
      ),
    );
  }
}
