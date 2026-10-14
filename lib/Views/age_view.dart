import 'package:flutter/material.dart';
import 'package:symptom_checker/Data/patient_data.dart';
import 'package:symptom_checker/Views/sex_view.dart';

import '../Styles/styles.dart';

class AgeView extends StatelessWidget {
  const AgeView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController = TextEditingController();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, _) {
        if (didPop) {
          return;
        }
        PatientData.instance.age = null;
        Navigator.of(context).pop();
      }),
      child: Scaffold(
        backgroundColor: backgroundWhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("How old are you?", style: textBigStyle),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("I am ", style: textSmallStyle),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
                      child: SizedBox(
                        width: 60,
                        child: TextField(
                          maxLength: 3,
                          keyboardType: TextInputType.number,
                          controller: textEditingController,
                          style: textSmallStyle,
                        ),
                      ),
                    ),
                    Text(" years old", style: textSmallStyle),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  String ageText = textEditingController.text;
                  if (ageText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter your age")),
                    );
                    return;
                  }
                  PatientData.instance.age = int.parse(ageText);
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const SexView()));
                },
                style: nextButtonStyle,
                child: Text("Next (1/5)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
