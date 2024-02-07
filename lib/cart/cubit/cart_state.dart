part of 'cart_cubit.dart';

enum CheckOutStatus {
  initial,
  redirected,
  success,
  canceled,
  error,
}

class CartState extends Equatable {
  const CartState(this.orderItems, this.totalPrice, this.checkOutStatus);

  factory CartState.initial() {
    return const CartState([], 0, CheckOutStatus.initial);
  }
  final List<Product> orderItems;
  final double totalPrice;
  final CheckOutStatus checkOutStatus;

  @override
  List<Object> get props => [orderItems, totalPrice, checkOutStatus];

  CartState copyWith({
    List<Product>? orderItems,
    double? totalPrice,
    CheckOutStatus? checkOutStatus,
  }) {
    return CartState(
      orderItems ?? this.orderItems,
      totalPrice ?? this.totalPrice,
      checkOutStatus ?? this.checkOutStatus,
    );
  }
}
