class ProductModel {
  String id;
  String name;
  String quantity;
  ProductModel({
    required this.id,
    required this.name,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> value) {
    return ProductModel(
        id: value['id'] as String? ?? '0',
        name: value['name'] as String? ?? '',
        quantity: value['quantity'] as String? ?? '');
  }
}
