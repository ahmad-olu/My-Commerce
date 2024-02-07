part of 'create_product_cubit.dart';

class CreateProductState extends Equatable {
  const CreateProductState({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.isLoading,
    required this.hasError,
    this.errorMessage,
  });
  factory CreateProductState.initial() {
    return const CreateProductState(
      name: '',
      description: '',
      price: 0,
      category: '',
      image: null,
      isLoading: false,
      hasError: false,
    );
  }
  final String name;
  final String description;
  final double price;
  final String category;
  final XFile? image;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  @override
  List<Object> get props =>
      [name, description, price, category, isLoading, hasError];

  CreateProductState copyWith({
    String? name,
    String? description,
    double? price,
    String? category,
    XFile? image,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return CreateProductState(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'CreateProductState(name: $name, description: $description, price: $price, category: $category, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage)';
  }
}
