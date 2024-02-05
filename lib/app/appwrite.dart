import 'package:appwrite/appwrite.dart';
import 'package:my_commerce/app/appwrite_const.dart';

class AppWrite {
  factory AppWrite._() {
    return instance;
  }

  AppWrite._internal() {
    client = Client()
            .setEndpoint(AppwriteConst.endpoint)
            .setProject(AppwriteConst.projectId)
        //.setSelfSigned(status: AppwriteConst.selfSignedIn)
        ;
  }
  static final AppWrite instance = AppWrite._internal();

  late final Client client;
}
