import 'package:appwrite/appwrite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_commerce/app/appwrite.dart';
import 'package:my_commerce/app/appwrite_const.dart';
import 'package:my_commerce/app/model/product.dart';

part 'create_product_state.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(CreateProductState.initial());
  final Databases db = Databases(AppWrite.instance.client);
  final Storage storage = Storage(AppWrite.instance.client);

  void imageFile(XFile? image) {
    emit(state.copyWith(image: image));
  }

  void nameStr(String value) {
    emit(state.copyWith(name: value));
  }

  void descriptionStr(String value) {
    emit(state.copyWith(description: value));
  }

  void priceDouble(double value) {
    emit(state.copyWith(price: value));
  }

  void categoryStr(String value) {
    emit(state.copyWith(category: value));
  }

  Future<void> upload() async {
    emit(state.copyWith(isLoading: true));

    final image = await storage.createFile(
      bucketId: AppwriteConst.imageProductBucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(
        path: state.image!.path,
      ),
    );

    final product = Product(
      name: state.name,
      description: state.description,
      price: state.price,
      category: state.category,
      image: AppwriteConst.imageUrl(image.$id),
    );
    try {
      await db.createDocument(
        databaseId: AppwriteConst.myCommerceOriginalId,
        collectionId: AppwriteConst.productsId,
        documentId: ID.unique(),
        data: product.toMap(),
      );
      emit(state.copyWith(isLoading: false));
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
          errorMessage: 'An Error occured',
        ),
      );
    }
  }
}
