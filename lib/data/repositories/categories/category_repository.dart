import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_shop/features/shop/models/category_model.dart';
import 'package:ecommerce_shop/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_shop/utils/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instace => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // throw 'Something went wrong. Please try again!';
      throw '';
    }
  }

  // Get sub categories

  // Upload categories to the cloud firestore
}
