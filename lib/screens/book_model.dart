class BookModel {
  int id;
  String name;
  String type;
  BookModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory BookModel.fromJson(Map<String, dynamic> value) {
    return BookModel(
        id: value['id'] as int? ?? 0,
        name: value['name'] as String? ?? '',
        type: value['type'] as String? ?? '');
  }
}
