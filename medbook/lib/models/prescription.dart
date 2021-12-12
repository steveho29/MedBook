class Presciption {
  final String name, dose, note;
  const Presciption(
      {required this.name, required this.dose, required this.note});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dose': dose,
      'note': note,
    };
  }
}
