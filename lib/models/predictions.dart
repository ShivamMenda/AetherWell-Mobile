class Pridections {
  late String diagnose;
  late double prediction;

  Pridections({
    required this.diagnose,
    required this.prediction,
  });

  factory Pridections.fromJson(Map<String, dynamic> json) {
    return Pridections(
      diagnose: json['diagnose'] as String,
      prediction: json['prediction'] as double,
    );
  }
}
