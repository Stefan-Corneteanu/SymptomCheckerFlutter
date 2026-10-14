import 'package:flutter/material.dart';
import 'package:symptom_checker/Data/patient_data.dart';
import 'package:symptom_checker/Views/symptoms_view.dart';

import '../Styles/styles.dart';

class RegionView extends StatefulWidget {
  const RegionView({super.key});

  @override
  State<StatefulWidget> createState() => RegionState();
}

class RegionState extends State<RegionView> {
  late String _selectedRegion;

  final List<String> _regions = [
    "North America",
    "Central America",
    "South America",
    "North Europe",
    "East Europe",
    "South Europe",
    "West Europe",
    "North Africa",
    "East Africa",
    "South Africa",
    "West Africa",
    "Central Africa",
    "Middle East",
    "India",
    "Far East",
    "Oceania",
  ];

  late final List<DropdownMenuEntry<String>> _dropdownMenuEntries = _regions
      .map((region) => DropdownMenuEntry(value: region, label: region))
      .toList();

  RegionState() {
    _selectedRegion = _regions[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("I am from: ", style: textBigStyle),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 20),
              child: DropdownMenu(
                initialSelection: _regions[0],
                dropdownMenuEntries: _dropdownMenuEntries,
                onSelected: (String? newRegion) {
                  setState(() {
                    _selectedRegion = newRegion!;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                PatientData.instance.region = _selectedRegion;
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const SymptomsView()));
              },
              style: nextButtonStyle,
              child: Text("Next (3/5)"),
            ),
          ],
        ),
      ),
    );
  }
}
