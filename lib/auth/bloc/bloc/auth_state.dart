part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState(this.appwriteUser, this.user);

  factory AuthState.initial() {
    return const AuthState(null, null);
  }

  final User? appwriteUser;
  final AppWriteDbUser? user;

  @override
  List<Object> get props => [];

  AuthState copyWith({
    User? appwriteUser,
    AppWriteDbUser? user,
  }) {
    return AuthState(
      appwriteUser ?? this.appwriteUser,
      user ?? this.user,
    );
  }

  @override
  String toString() => 'AuthState(appwriteUser: $appwriteUser, user: $user)';
}
