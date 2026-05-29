import 'package:ecommerce_shop/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce_shop/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

// Entry Point of Flutter App
Future<void> main() async {

  // Add Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // GetX local storage
  await GetStorage.init();

  // Await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Initialize Firebasae
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
     (FirebaseApp value) => Get.put(AuthenticationRepository())
   );

  
  //  SocketService().connect();



//Running The Application
  runApp(App());
}
