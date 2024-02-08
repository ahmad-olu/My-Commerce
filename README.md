# My Commerce
built with flutter, appwrite, and stripe
---

## Motivation
i wanted to try out different payment method like stripe,adapty or flutter_wave and most job posting keeps looking for someone who has build some financial or e-commerce app. so here is one of the above or sidey 😉 [You get it]

---

## Getting Started 🚀

### Create an Appwrite project with models
#### user
```dart
  final String id;
  final String email;
  final bool isAdmin;
``` 
#### Product
```dart
  final String? id; //$id
  final String name;
  final String description;
  final double price;
  final String category;
  final String image;
``` 

### to run the flutter project
clone the repo: https://github.com/ahmad-olu/My-Commerce.git

#### create some constant values in :
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

### create a stripe account:
to use test card. if you are using test secretKey and test publishableKey 
- Email: test@example.com
- Card information: 4242 4242 4242 4242
- Exp: 12/34
- Key: 567
- Name on Card: Zhang San
- Country or region: United States
- Zip Code: 12345

When you are done with the above to run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

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

## usage

- Open the app if you are logged in. 
- if you make isAdmin true in your appwrite console for your logged in user. you are able to create product.
- you can click on a product to add to your cart or remove it from your cart and buy the product through stripe payment


## Note
1. stripe only works on android, ios and web. but the app was only tested on a physical android and failed as a windows app
2. stripe does not have registration for some country like were i live [nigeria] but that does not stop your customer from using it. it only affects the developer to get an account with stripe