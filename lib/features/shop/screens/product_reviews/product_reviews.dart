import 'package:ecommerce_shop/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_shop/common/widgets/products/ratings/rating_indicator.dart';
import 'package:ecommerce_shop/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:ecommerce_shop/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:ecommerce_shop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //App bar
      appBar: TAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),

      //Body
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Ratings and Reviews are verified and are from people who use the same type of device that you use.'),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //Overall Product Ratings
              TOverallProductRating(),
              TRatingBarIndicator(rating: 3.5,),
              Text('12,611', style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: TSizes.spaceBtwSections,),
              
              //User Review List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}

