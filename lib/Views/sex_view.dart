import 'package:flutter/material.dart';
import 'package:symptom_checker/Data/patient_data.dart';
import 'package:symptom_checker/Views/region_view.dart';

import '../Styles/styles.dart';

class SexView extends StatefulWidget {
  const SexView({super.key});

  @override
  State<SexView> createState() => SexState();
}

class SexState extends State<SexView> {
  Sex? _selectedSex;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, _) {
        if (didPop) {
          return;
        }
        PatientData.instance.sex = null;
        Navigator.of(context).pop();
      }),
      child: Scaffold(
        backgroundColor: backgroundWhite,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("I am a: ", style: textBigStyle),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 20),
                child: RadioGroup<Sex>(
                  groupValue: _selectedSex,
                  onChanged: (Sex? value) {
                    setState(() {
                      _selectedSex = value;
                    });
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          title: Text("Male", style: textSmallStyle),
                          value: Sex.male,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          title: Text("Female", style: textSmallStyle),
                          value: Sex.female,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedSex == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select a sex")),
                    );
                    return;
                  }
                  PatientData.instance.sex = _selectedSex;
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const RegionView()));
                },
                style: nextButtonStyle,
                child: Text("Next (2/5)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
