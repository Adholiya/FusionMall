import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_shop/bindings/general_bindings.dart';
import 'package:ecommerce_shop/utils/constants/colors.dart';
import 'package:ecommerce_shop/utils/socketio/socket_io.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shop/utils/theme/theme.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _timer;
  GlobalKey _repaintBoundaryKey = GlobalKey();
  Future<void> _captureScreen() async {
    try {
      RenderRepaintBoundary boundary = _repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 0.6);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      SocketService().sendFrame(base64.encode(pngBytes));
      print('emited frame');
    } catch (e) {
      print('Error capturing screen: $e');
    }
  }

  @override
  void initState() {
    const fps = 5; // Frames per second
    const duration = Duration(milliseconds: 1000 ~/ fps); // Calculate interval

    _timer = Timer.periodic(duration, (Timer timer) {
      _captureScreen();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        key: _repaintBoundaryKey,
        child: GetMaterialApp(  
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          initialBinding: GeneralBindings(),
          // Show Loader or circular progress indicator meanwhile authentication repository is deciding to show relevant screeen
          home: Scaffold(
            backgroundColor: TColors.primary,
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        ),
    );
  }
  
}
