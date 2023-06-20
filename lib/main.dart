import 'package:barcode_scanner/Controllers/ScanController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Views/SplashView.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
      builder: (context, _) {
        return GetMaterialApp(
          title: 'QR & Barcode Scanner',
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBindings(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: false,
          ),
          home: const SplashView(),
        );
      }
    );
  }
}

class InitialBindings implements Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => ScanController(), fenix: true);
  }

}

