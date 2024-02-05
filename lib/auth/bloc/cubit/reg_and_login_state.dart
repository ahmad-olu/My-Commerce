part of 'reg_and_login_cubit.dart';

class RegAndLoginState extends Equatable {
  const RegAndLoginState({
    required this.email,
    required this.password,
    required this.errorMessage,
    required this.isLoading,
    required this.hasError,
  });

  factory RegAndLoginState.initial() {
    return const RegAndLoginState(
      email: '',
      password: '',
      errorMessage: null,
      isLoading: false,
      hasError: false,
    );
  }
  final String email;
  final String password;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, isLoading, hasError];

  RegAndLoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return RegAndLoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'RegAndLoginState(email: $email, password: $password, isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage)';
  }
}
