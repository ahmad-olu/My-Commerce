import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_commerce/app/appwrite.dart';
import 'package:my_commerce/app/appwrite_const.dart';
import 'package:my_commerce/app/model/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initial()) {
    on<GetUserDetails>((event, emit) async {
      try {
        final acc = await account.get();
        final db = await database
            .getDocument(
              databaseId: AppwriteConst.myCommerceOriginalId,
              collectionId: AppwriteConst.usersId,
              documentId: acc.$id,
            )
            .then((value) => AppWriteDbUser.fromMap(value.data));
        emit(state.copyWith(appwriteUser: acc, user: db));
      } on AppwriteException catch (e) {
        log('unable to get user ${e.message}');
      } catch (e) {
        log('unable to get user ');
      }
    });
  }
  final Account account = Account(AppWrite.instance.client);
  final Databases database = Databases(AppWrite.instance.client);
}
