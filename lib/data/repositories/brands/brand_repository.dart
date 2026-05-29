import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_shop/features/shop/models/brand_model.dart';
import 'package:ecommerce_shop/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_shop/utils/exceptions/format_exception.dart';
import 'package:ecommerce_shop/utils/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController{
  static BrandRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;

  // Get all brands
  Future<List<BrandModel>> getAllBrands() async {
    try {

      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // throw 'Something Went Wrong';
      throw '';
    }
  }

  // Get brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {

      // Query to get all documents
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();

      // Extratc brand ids from document
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;

    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something Went Wrong';
    }
  }
}