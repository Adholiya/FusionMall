import 'package:ecommerce_shop/features/personalization/screens/settings/settings.dart';
import 'package:ecommerce_shop/features/shop/screens/ai/chatbot.dart';
import 'package:ecommerce_shop/features/shop/screens/home/home.dart';
import 'package:ecommerce_shop/features/shop/screens/store/store.dart';
import 'package:ecommerce_shop/features/shop/screens/wishlist/wishlist.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/helpers/helper_functions.dart';
import 'package:ecommerce_shop/utils/network/loaders.dart';
import 'package:ecommerce_shop/utils/socketio/socket_io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  // late Ticker _ticker;
  // Timer? _timer;
  // int sec = 0;

  // GlobalKey _repaintBoundaryKey = GlobalKey();

  final controller = Get.put(NavigationController());

  // Future<void> _captureScreen() async {
  //   try {
  //     RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
  //         .findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage(pixelRatio: 0.5);
  //     ByteData? byteData =
  //         await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytes = byteData!.buffer.asUint8List();
  //     SocketService().sendFrame(base64.encode(pngBytes));
  //     print('emited frame');
  //     // Save the image to a file
  //     // final directory = (await getApplicationDocumentsDirectory()).path;
  //     // File imgFile = File('$directory/screenshot.png');
  //     // imgFile.writeAsBytes(pngBytes);

  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Screenshot saved to $directory/screenshot.png')));
  //   } catch (e) {
  //     print('Error capturing screen: $e');
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    // _ticker = Ticker((elapsed) {
    //   if (elapsed.inMilliseconds % 3000 == 0) {
    //       sec++;
    //       _captureScreen();
    //       controller.update();
    //     }
    // });
    // _ticker.start();
    // const fps = 1; // Frames per second
    // const duration = Duration(milliseconds: 1000 ~/ fps); // Calculate interval

    // _timer = Timer.periodic(duration, (Timer timer) {
    //   _captureScreen();
    // });
    super.initState();
  }

  @override
  void dispose() {
    // _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    int shareStatus = -1;
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 55),
        child: FloatingActionButton(
          backgroundColor: TColors.white,
          onPressed: () async {
            if (shareStatus == -1) {
              TLoaders.warningSnackBar(
                  title: 'Screen Share Starting',
                  message: 'Your Screen Sharing Will Start in 8 Seconds');
              await Future.delayed(Duration(seconds: 8));
              SocketService().connect();
              TLoaders.errorSnackBar(
                  title: 'Screen Share Started',
                  message: 'Your Screen is Being Shared');
              shareStatus = 0;
            } else {
              TLoaders.warningSnackBar(
                  title: 'Screen Share Stopping',
                  message: 'Your Screen Sharing Will Stop in 8 Seconds');
              await Future.delayed(Duration(seconds: 8));
              SocketService().disconnect();
              TLoaders.errorSnackBar(
                  title: 'Screen Share Stopped',
                  message: 'Your Screen Sharing is Stopped');
              shareStatus = -1;
            }
          },
          child: Icon(Iconsax.share, color: const Color.fromARGB(255, 0, 194, 174),),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: [
            const NavigationDestination(
                icon: Icon(Iconsax.home), label: 'Home'),
            const NavigationDestination(
                icon: Icon(Iconsax.shop), label: 'Store'),
            const NavigationDestination(
                icon: Icon(Iconsax.heart), label: 'Wishlist'),
            const NavigationDestination(
                icon: Icon(Iconsax.user), label: 'Profile'),
            const NavigationDestination(
                icon: Icon(Iconsax.message), label: 'AI'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
    const ChatScreen(),
  ];
}
