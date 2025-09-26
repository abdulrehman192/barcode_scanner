import 'package:barcode_scanner/Controllers/DashboardController.dart';
import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Controllers/ScanController.dart';
import 'package:barcode_scanner/Controllers/SettingsController.dart';
import 'package:barcode_scanner/Core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Views/SplashView.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
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
          title: 'Scanify: QR & Barcode Scanner & Generator',
          debugShowCheckedModeBanner: false,
          initialBinding: InitialBindings(),
          theme: AppTheme.getLightTheme(context),
          home: const SplashView(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        );
      }
    );
  }
}

class InitialBindings implements Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => QRController(), fenix: true);
    Get.lazyPut(() => DashboardController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => ScanController(), fenix: true);
  }

}

