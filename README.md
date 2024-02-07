# My Commerce
---

## Getting Started 🚀

### Create an Appwrite project with data
#### user
```dart
  final String id;
  final String email;
  final bool isAdmin;
``` 

```dart
  final String? id; //$id
  final String name;
  final String description;
  final double price;
  final String category;
  final String image;
``` 

### create some constant values in :
```
├── app
│   ├── app.dart
│   ├── appwrite_const.dart
```
with values :
```dart
class AppwriteConst {
  static const String endpoint = 'https://cloud.appwrite.io/v1';
  static const String projectId = '';

  static const String myCommerceOriginalId = '';

  static const String usersId = '';
  static const String productsId = '';


  static const String imageProductBucketId = '';

  static String imageUrl(String imageId) =>
      '$endpoint/storage/buckets/$imageProductBucketId/files/$imageId/view?project=$projectId&mode=admin';

  //stripe
  static const String secretKey =
      'sk_test_XXX';
  static const String publishableKey =
      'pk_test_XXX';
}

```

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*My Commerce works on iOS, Android, Web, and Windows._

---
