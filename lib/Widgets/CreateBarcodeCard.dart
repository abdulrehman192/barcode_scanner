import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Views/QRInputView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Models/QRCreateItem.dart';
import '../Views/BarcodeInputView.dart';

class CreateBarcodeCard extends StatelessWidget {
  final String title;
  const CreateBarcodeCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        QRController controller = Get.find();
        controller.inputController.clear();
        controller.generated = false;
        controller.barcodeHint(title);
        Get.to(() => BarcodeInputView(title: title));
      },
      child: Column(
        children: [
          Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  color: Colors.grey.shade200
                )
              ]
            ),
            child: Container(
              padding: EdgeInsets.all(12.h),

              child: Image.asset("assets/images/barcode.png", width: 33.w,)
            ),
          ),
          SizedBox(height: 5.h,),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
