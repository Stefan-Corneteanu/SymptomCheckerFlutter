import 'package:flutter/material.dart';
import 'package:symptom_checker/Data/patient_data.dart';
import 'package:symptom_checker/Views/risks_view.dart';

import '../Styles/styles.dart';

class SymptomListEntryView extends StatelessWidget {
  final String _symptom;
  final Function(String) _delete;

  const SymptomListEntryView({
    super.key,
    required this._symptom,
    required this._delete
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(_symptom, style: textSmallStyle),
        IconButton(
          onPressed: () {
            _delete(_symptom);
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}

class SymptomsView extends StatefulWidget {
  const SymptomsView({super.key});

  @override
  State<StatefulWidget> createState() => SymptomsState();
}

class SymptomsState extends State<SymptomsView> {
  final Set<String> _symptoms = {};
  final TextEditingController _textEditingController = TextEditingController();

  void deleteSymptom(String symptom) {
    setState(() {
      _symptoms.remove(symptom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, _) {
        if (didPop) {
          return;
        }
        PatientData.instance.clearSymptoms();
        Navigator.of(context).pop();
      }),
      child: Scaffold(
        backgroundColor: backgroundWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(top: 20),
              child: Text("What are your symptoms?", style: textBigStyle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("I have: ", style: textSmallStyle,),
                Expanded(child: TextField(
                  controller: _textEditingController,
                  style: textSmallStyle,
                )),
                IconButton(
                  onPressed: () {
                    String symptom = _textEditingController.text;
                    _textEditingController.clear();
                    if (symptom.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a valid symptom"),
                        ),
                      );
                      return;
                    }
                    if (_symptoms.contains(symptom)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Symptom already inputted"),
                        ),
                      );
                      return;
                    }
                    setState(() {
                      _symptoms.add(symptom);
                    });
                  },
                  style: otherButtonStyle,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: _symptoms
                    .map((el) => SymptomListEntryView(symptom: el, delete: deleteSymptom))
                    .toList(),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (_symptoms.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please add at least one symptom"),
                      ),
                    );
                    return;
                  }
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const RisksView()));
                },
                style: nextButtonStyle,
                child: Text("Next (4/5)"),
              ),
            ),
            Padding(padding: EdgeInsetsGeometry.only(bottom: 50)), // so that the submit button is visible despite the snackbar popping up
          ],
        ),
      ),
    );
  }
}
