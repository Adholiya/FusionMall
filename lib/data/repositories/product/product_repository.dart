import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_shop/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce_shop/features/shop/models/product_model.dart';
import 'package:ecommerce_shop/features/shop/models/product_variation_model.dart';
import 'package:ecommerce_shop/utils/exceptions/firebase_exception.dart';
import 'package:ecommerce_shop/utils/exceptions/format_exception.dart';
import 'package:ecommerce_shop/utils/exceptions/platform_exception.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // FireStore instance for database interactions
  final _db = FirebaseFirestore.instance;

  void createFeaturedProduct() {
    final snapshot = _db.collection('Products').add(ProductModel(
            id: '003',
            title: 'GLORYBOYZ Half Shirt for Men Cotton Check',
            stock: 15,
            price: 699.0,
            thumbnail: 'assets/images/products/shirt1a.png',
            productType: 'ProductType.variable',
            productAttributes: [
              ProductAttributeModel(name: 'Color', values: ['Grey', 'Green']),
              ProductAttributeModel(name: 'Size', values: ['XL', '2XL'])
            ],
            productVariations: [
              ProductVariationModel(
                  id: '0',
                  attributeValues: {'Color': 'Green', 'Size': '2XL'},
                  description: 'This is Green Color Check Shirt',
                  image: 'assets/images/products/shirt1a4.png',
                  price: 999.0,
                  salePrice: 699.0,
                  sku: '',
                  stock: 34),
              ProductVariationModel(
                  id: '1',
                  attributeValues: {'Color': 'Grey', 'Size': '3XL'},
                  description: 'This is Grey Color Check Shirt',
                  image: 'assets/images/products/shirt1a3.png',
                  price: 999.0,
                  salePrice: 699.0,
                  sku: '',
                  stock: 34)
            ]).toJson());
  }

  // Get limited featured products
  Future<List<ProductModel>>  getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .get(); //.where('IsFeatured', isEqualTo: true).limit(4).get();
      print('snapshot data:  ${snapshot.docs}');
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } catch (e) {
      // throw 'Something went wrong. Please try again!';
      rethrow;
    }
  }
}
