import 'package:flutter/material.dart';
import 'package:symptom_checker/Views/age_view.dart';

import '../Styles/styles.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(bottom: 20),
              child: Text(
                "Welcome! Press start to begin",
                style: textBigStyle,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const AgeView()));
              },
              style: nextButtonStyle,
              child: Text("Start"),
            ),
          ],
        ),
      ),
    );
  }
}
