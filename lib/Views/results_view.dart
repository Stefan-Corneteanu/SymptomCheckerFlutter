import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:symptom_checker/Data/patient_data.dart';

import '../Styles/styles.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});

  @override
  State<StatefulWidget> createState() => ResultsState();
}

class ResultsState extends State<ResultsView> {
  bool diseasesRetrieved = false;
  List<String>? diseases;
  ResultsState() {
    getDiseases();
  }

  void getDiseases() async {
    List<String> tempDiseases = [];
    try{
      final Uri uri = Uri.parse("http://10.0.2.2:8080/diseases");
      final Map<String, String> headers = {
        "Content-Type": "application/json",
        "Accept":  "application/json",
      };

      final http.Response response = await http.post(
        uri,
        headers: headers,
        body: PatientData.instance.toString()
      ).timeout(Duration(seconds: 10));
      tempDiseases = jsonDecode(response.body)["diseases"];
    }
    on Exception catch (e){
      if (kDebugMode) {
        print(e);
      }
    }

    setState(() {
      diseases = tempDiseases;
      diseasesRetrieved = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!diseasesRetrieved)
                const CircularProgressIndicator()
              else if (diseases == null || diseases!.isEmpty)
                Text("An error occurred while trying to communicate with the server", style: textErrorStyle,)
              else
                Text("You may be suffering of: ${diseases!.join(", ")}", style: textBigStyle,)
            ]
        )
      ),
    );
  }

}