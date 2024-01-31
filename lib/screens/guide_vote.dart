import 'package:flutter/material.dart';
import 'package:mypolling/screens/sign_up_page.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final PageController _pageController = PageController();

  final List<Widget> introPages = [
    IntroPageWidget(
      title: 'Bienvenue sur',
      description:
      "L'application de vote en ligne qui change vos habitudes de vote avec des sondages bien compréhensibles",
      image: 'assets/images/img',
      index: 1,
    ),
    IntroPageWidget(
      title: 'Avec',
      description:
      'Vous pourrez faire vos votes à partir des options bien claires, précises et bien définies par vous-même. Vous aurez également la possibilité de faire des votes en direct.',
      image: 'assets/images/img',
      index: 2,
    ),
    IntroPageWidget(
      title: 'Pour couronner',
      description:
      'Vous affiche les résultats en permanence et vous permet de les partager en fin de vote',
      image: 'assets/images/img',
      index: 3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "MyPolling",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.blue,
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: introPages.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: introPages[index],
            ),
          );
        },
      ),
    );
  }
}

class IntroPageWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final int index;

  IntroPageWidget({
    required this.title,
    required this.description,
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                      const SignupPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        animation = CurvedAnimation(
                            parent: animation, curve: Curves.ease);
                        var begin = const Offset(1.0, 1.0);
                        var end = Offset.zero;
                        var tween = Tween(begin: begin, end: end);
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text(
                  "Passer",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 25)),
          Image.asset(
            "$image.png",
            alignment: Alignment.center,
          ),
          const Padding(padding: EdgeInsets.only(top: 25)),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(2, 5),
                  spreadRadius: 3,
                )
              ],
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.1),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: const Divider(),
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                const Text(
                  "MyPolling",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                Text(
                  description,
                  style: const TextStyle(color: Colors.black54, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            constraints: const BoxConstraints(
              minHeight: 120,
            ),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 120,
                  ),
                  width: double.infinity,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "$index/3",
                        style: const TextStyle(color: Colors.blue, fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
