class Hospital {
  String city, name;
  List<String> doctorId;
  Hospital.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        name = json['name'],
        doctorId = json['doctors'];
}
