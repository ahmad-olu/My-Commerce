import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_commerce/app/appwrite.dart';
import 'package:my_commerce/app/appwrite_const.dart';

part 'reg_and_login_state.dart';

class RegAndLoginCubit extends Cubit<RegAndLoginState> {
  RegAndLoginCubit() : super(RegAndLoginState.initial());
  final Account account = Account(AppWrite.instance.client);
  final Databases db = Databases(AppWrite.instance.client);

  void emailStr(String value) {
    emit(state.copyWith(email: value));
  }

  void passwordStr(String value) {
    emit(state.copyWith(password: value));
  }

  Future<void> register() async {
    emit(state.copyWith(isLoading: true));
    try {
      final accountRes = await account.create(
        userId: ID.unique(),
        email: state.email,
        password: state.password,
      );

      await db.createDocument(
        databaseId: AppwriteConst.myCommerceOriginalId,
        collectionId: AppwriteConst.usersId,
        documentId: accountRes.$id,
        data: {
          'email': state.email,
        },
      );

      final login = await account.createEmailSession(
        email: state.email,
        password: state.password,
      );

      emit(state.copyWith(isLoading: false));
    } on AppwriteException catch (e, _) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: '${e.message} => ${e.code}',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: 'Error Occurred',
        ),
      );
    }
  }

  Future<void> login() async {
    emit(state.copyWith(isLoading: true));
    try {
      final login = await account.createEmailSession(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(isLoading: false));
    } on AppwriteException catch (e, _) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: '${e.message} => ${e.code}',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: 'Error Occurred',
        ),
      );
    }
  }
}
