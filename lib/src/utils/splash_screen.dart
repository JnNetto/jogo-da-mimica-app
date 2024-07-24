import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../views/home/home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<StatefulWidget> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      backgroundColor: const Color.fromARGB(255, 50, 50, 50),
      childWidget: SizedBox(
          height: 200,
          width: 200,
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              margin: const EdgeInsets.only(top: 1, bottom: 10),
              child: Lottie.asset("assets/animations/Mimic.json",
                  width: constraints.maxWidth * .6, fit: BoxFit.cover),
            );
          })),
      asyncNavigationCallback: () async {
        await Future.delayed(const Duration(milliseconds: 4500));
        if (context.mounted) {
          Navigator.push(
            context,
            PageRouteBuilder<void>(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return const Home();
              },
              transitionsBuilder: (
                ___,
                Animation<double> animation,
                ____,
                Widget child,
              ) {
                Animation<double> curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                );

                return FadeTransition(
                  opacity: curvedAnimation,
                  child: child,
                );
              },
            ),
          );
        }
      },
    );
  }
}
