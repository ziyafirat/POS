class ItemModel {
  final String id;
  final String name;
  final double price;
  final String barcode;
  final int quantity;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.barcode,
    this.quantity = 1,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      barcode: json['barcode'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'barcode': barcode,
      'quantity': quantity,
    };
  }

  ItemModel copyWith({
    String? id,
    String? name,
    double? price,
    String? barcode,
    int? quantity,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      barcode: barcode ?? this.barcode,
      quantity: quantity ?? this.quantity,
    );
  }

  double get totalPrice => price * quantity;
}
