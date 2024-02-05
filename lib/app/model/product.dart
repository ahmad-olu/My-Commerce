class Product {
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.id,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: (map[r'$id'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      description: (map['description'] ?? '') as String,
      // ignore: avoid_dynamic_calls
      price: (map['price']?.toDouble() ?? 0.0) as double,
      category: (map['category'] ?? '') as String,
      image: (map['image'] ?? '') as String,
    );
  }

  final String? id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String image;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, description: $description, price: $price, category: $category, image: $image)';
  }
}
