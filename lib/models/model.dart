class StudentModel {
  int? id;
  String? name;
  String? age;
  String? addNO;
  String? place;
  String? image;

  StudentModel({
    required this.id,
    required this.name,
    required this.age,
    required this.addNO,
    required this.place,
    required this.image,
  });

  static StudentModel fromMap(Map<String, Object?> mapping) {
    final id = mapping['id'] as int;
    final name = mapping['name'] as String;
    final age = mapping['age'] as String;
    final addNO = mapping['addno'] as String;
    final place = mapping['place'] as String;
    final image = mapping['image'] as String;

    return StudentModel(
      id: id,
      name: name,
      age: age,
      addNO: addNO,
      place: place,
      image: image,
    );
  }
}
