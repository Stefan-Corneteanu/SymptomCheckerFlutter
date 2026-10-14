enum Sex {
  male, female
}

enum BMICategory {
  underweight, normal, overweight, obese
}

class PatientData {
  /// region instance data
  Sex? sex;
  int? age;
  String? region;
  final List<String> _symptoms = [];
  BMICategory? bmiCat;
  bool isSmoker = false;
  bool isAlcoholic = false;
  bool isWorkaholic = false;
  /// endregion

  /// region instance and instantiation
  static PatientData? _instance;

  PatientData._();

  static PatientData get instance => _instance ??= PatientData._();

  /// endregion

  /// region behavior
  void addSymptom(String symptom) {
    _symptoms.add(symptom);
  }

  void clearSymptoms() {
    _symptoms.clear();
  }

  @override
  String toString() {
    return """{
      "Sex": $sex,
      "Age": $age,
      "Region": $region,
      "Symptoms": $_symptoms,
      "BMICategory": $bmiCat,
      "Smoker": $isSmoker,
      "Alcoholic": $isAlcoholic,
      "Workaholic": $isWorkaholic,
    }""";
  }
  /// endregion
}