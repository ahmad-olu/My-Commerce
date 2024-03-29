class Orders {
  Orders({
    required this.userId,
    required this.status,
    required this.totalAmount,
    this.id,
  });

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      id: (map[r'$id'] ?? '') as String,
      userId: (map['user_id'] ?? '') as String,
      status: (map['status'] ?? false) as bool,
      // ignore: avoid_dynamic_calls
      totalAmount: (map['total_amount']?.toDouble() ?? 0.0) as double,
    );
  }

  factory Orders.empty() {
    return Orders(
      status: false,
      totalAmount: 0,
      userId: '',
    );
  }

  final String? id;
  final String userId;
  final bool status;
  final double totalAmount;

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'status': status,
      'total_amount': totalAmount,
    };
  }

  @override
  String toString() {
    return 'Orders(id: $id, userId: $userId, status: $status, totalAmount: $totalAmount)';
  }
}
