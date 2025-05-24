import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Views/QRInputView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Models/QRCreateItem.dart';

class CreateQRCard extends StatelessWidget {
  final QRCreateItem item;
  const CreateQRCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        QRController controller = Get.find();
        controller.inputController.clear();
        controller.generated = false;
        controller.updateHintText(item.title);
        if(item.title == "Clipboard")
          {
            ClipboardData? data = await Clipboard.getData('text/plain');
            if(data != null)
              {
                controller.inputController.text = data.text.toString();
                controller.generated = true;
              }
          }
        Get.to(() => QRInputView(title: item.title));
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

              child: SvgPicture.asset(item.imageUrl, width: 33.w,)
            ),
          ),
          SizedBox(height: 5.h,),
          Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
