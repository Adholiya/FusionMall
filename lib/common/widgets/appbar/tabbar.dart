import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/device/device_utility.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;
  
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: TColors.primary,
        labelColor: dark ? TColors.white : TColors.primary,
        unselectedLabelColor: TColors.darkGrey,
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  @override  
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
