import 'package:barcode_scanner/Controllers/ScanController.dart';
import 'package:barcode_scanner/Views/QRScanView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR & Barcode Scanner"),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light
        ),
      ),
      body: GetBuilder<ScanController>(
        builder: (controller)
        {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Get.to(() => const QRScanView());
                    },
                    child: const Text("Scan Code")
                ),
                SizedBox(height: 20.h,),
                controller.barcode == null ? const SizedBox.shrink():
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Scanned Data : ", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("${controller.barcode!.displayValue}"),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
