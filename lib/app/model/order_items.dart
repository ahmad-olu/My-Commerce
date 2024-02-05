class OrderItems {
  OrderItems({
    required this.orderId,
    required this.productId,
    this.quantity,
    this.id,
  });

  factory OrderItems.fromMap(Map<String, dynamic> map) {
    return OrderItems(
      id: (map['id']) as String,
      orderId: (map['order_id'] ?? '') as String,
      productId: (map['product_id'] ?? '') as String,
      // ignore: avoid_dynamic_calls
      quantity: map['quantity']?.toDouble() as double,
    );
  }

  final String? id;
  final String orderId;
  final String productId;
  final double? quantity;

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
    };
  }
}
