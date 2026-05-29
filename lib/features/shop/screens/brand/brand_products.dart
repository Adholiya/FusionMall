import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/common/widgets/brand/brand_card.dart';
import 'package:ecommerce_shop/common/widgets/products/sortable/sortable_products.dart';
import 'package:ecommerce_shop/features/shop/models/brand_model.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        title: Text('Nike'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //Brand Detail
              TBrandCard(showBorder: true, brand: BrandModel.empty(),),
              SizedBox(height: TSizes.spaceBtwSections,),

              TSortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
