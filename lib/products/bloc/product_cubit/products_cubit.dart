import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_commerce/app/appwrite.dart';
import 'package:my_commerce/app/appwrite_const.dart';
import 'package:my_commerce/app/model/product.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsState.initial());
  final Databases db = Databases(AppWrite.instance.client);

  Future<void> getProducts() async {
    emit(state.copyWith(isLoading: true));
    try {
      final prod = await db.listDocuments(
        databaseId: AppwriteConst.myCommerceOriginalId,
        collectionId: AppwriteConst.productsId,
      );
      //  log('+++++++ ${prod.documents.map((e) => e.data)}');
      final product =
          prod.documents.map((e) => Product.fromMap(e.data)).toList();
      emit(state.copyWith(isLoading: false, products: product));
    } on AppwriteException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: '${e.code} => ${e.message}',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: 'Error occurred',
        ),
      );
    }
  }
}
