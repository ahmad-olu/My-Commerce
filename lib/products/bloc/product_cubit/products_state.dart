part of 'products_cubit.dart';

class ProductsState extends Equatable {
  const ProductsState({
    required this.products,
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
  });

  factory ProductsState.initial() {
    return const ProductsState(
      products: [],
      hasError: false,
      isLoading: false,
    );
  }
  final List<Product> products;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  @override
  List<Object> get props => [products, isLoading, hasError];

  ProductsState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'ProductsState(products: $products, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage)';
  }
}
