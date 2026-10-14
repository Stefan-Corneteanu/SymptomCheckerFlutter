import 'dart:math';

import 'package:flutter/material.dart';
import 'package:symptom_checker/Data/patient_data.dart';
import 'package:symptom_checker/Views/results_view.dart';

import '../Styles/styles.dart';

class RisksView extends StatefulWidget {
  const RisksView({super.key});

  @override
  State<StatefulWidget> createState() => RisksState();
}

class RisksState extends State<RisksView> {
  bool _isSmoker = false;
  bool _isAlcoholic = false;
  bool _isWorkaholic = false;
  double? _bmiVal;
  BMICategory? _bmiCat;
  bool _usedCalculatorToDetermineBMI = false;

  BMICategory determineBMICategory(double bmi) {
    if (bmi < 18.5) {
      return BMICategory.underweight;
    } else if (bmi < 25) {
      return BMICategory.normal;
    } else if (bmi < 30) {
      return BMICategory.overweight;
    } else {
      return BMICategory.obese;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController weightTextEditingController =
        TextEditingController();
    final TextEditingController heightTextEditingController =
        TextEditingController();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: ((didPop, _) {
        if (didPop) {
          return;
        }

        PatientData.instance.isSmoker = false;
        PatientData.instance.isAlcoholic = false;
        PatientData.instance.isWorkaholic = false;
        PatientData.instance.bmiCat = null;

        Navigator.of(context).pop();
      }),
      child: Scaffold(
        backgroundColor: backgroundWhite,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 20),
                child: Text("I'm a(n):", style: textBigStyle),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CheckboxListTile(
                    value: _isSmoker,
                    horizontalTitleGap: 0,
                    title: Text("Smoker", style: textSmallStyle),
                    onChanged: (bool? value) {
                      setState(() {
                        _isSmoker = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    value: _isAlcoholic,
                    title: Text("Alcoholic", style: textSmallStyle),
                    horizontalTitleGap: 0,
                    onChanged: (bool? value) {
                      setState(() {
                        _isAlcoholic = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    value: _isWorkaholic,
                    title: Text("Workaholic", style: textSmallStyle),
                    horizontalTitleGap: 0,
                    onChanged: (bool? value) {
                      setState(() {
                        _isWorkaholic = value!;
                      });
                    },
                  ),
                ],
              ),

              Padding(padding: EdgeInsetsGeometry.only(bottom: 20)),

              RadioGroup<BMICategory>(
                groupValue: _bmiCat,
                onChanged: (BMICategory? value) {
                  setState(() {
                    _bmiCat = value;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioListTile(
                      title: Text("Underweight", style: textSmallStyle),
                      horizontalTitleGap: 0,
                      value: BMICategory.underweight,
                      enabled: !_usedCalculatorToDetermineBMI,
                    ),
                    RadioListTile(
                      title: Text("Normal", style: textSmallStyle),
                      horizontalTitleGap: 0,
                      value: BMICategory.normal,
                      enabled: !_usedCalculatorToDetermineBMI,
                    ),
                    RadioListTile(
                      title: Text("Overweight", style: textSmallStyle),
                      horizontalTitleGap: 0,
                      value: BMICategory.overweight,
                      enabled: !_usedCalculatorToDetermineBMI,
                    ),
                    RadioListTile(
                      title: Text("Obese", style: textSmallStyle),
                      horizontalTitleGap: 0,
                      value: BMICategory.obese,
                      enabled: !_usedCalculatorToDetermineBMI,
                    ),
                  ],
                ),
              ),

              Padding(padding: EdgeInsetsGeometry.only(bottom: 20)),

              Text(
                "You can use the BMI calculator if unsure",
                style: textBigStyle,
              ),

              Padding(padding: EdgeInsetsGeometry.only(bottom: 20)),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Weight(kg): ", style: textSmallStyle),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: weightTextEditingController,
                          style: textSmallStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Height(m): ", style: textSmallStyle),
                      SizedBox(
                        width: 60,
                        child: TextField(
                          maxLength: 3,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: heightTextEditingController,
                          style: textSmallStyle,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "BMI (weight / height^2 ) = ${_bmiVal?.toStringAsFixed(2) ?? ""}",
                    style: textSmallStyle,
                  ),
                ],
              ),

              Padding(padding: EdgeInsetsGeometry.only(bottom: 20)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String weightText = weightTextEditingController.text;
                      String heightText = heightTextEditingController.text;

                      if (weightText.isEmpty || heightText.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Missing inputs")),
                        );
                        return;
                      }

                      double weight = double.parse(weightText);
                      double height = double.parse(heightText);
                      setState(() {
                        _bmiVal = weight / pow(height, 2);
                        _bmiCat = determineBMICategory(_bmiVal!);
                        _usedCalculatorToDetermineBMI = true;
                      });
                    },
                    style: otherButtonStyle,
                    child: Text("Compute"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      weightTextEditingController.clear();
                      heightTextEditingController.clear();
                      setState(() {
                        _bmiVal = null;
                        _bmiCat = null;
                        _usedCalculatorToDetermineBMI = false;
                      });
                    },
                    style: otherButtonStyle,
                    child: Text("Reset"),
                  ),
                ],
              ),

              Padding(padding: EdgeInsetsGeometry.only(bottom: 20)),

              ElevatedButton(
                onPressed: () {
                  if (_bmiCat == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select your BMI category"),
                      ),
                    );
                    return;
                  }
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ResultsView()),
                  );
                },
                style: nextButtonStyle,
                child: Text("Submit(5/5)"),
              ),

              Padding(padding: EdgeInsetsGeometry.only(bottom: 70)), // so that the submit button is visible despite the snackbar popping up
            ],
          ),
        ),
      ),
    );
  }
}
