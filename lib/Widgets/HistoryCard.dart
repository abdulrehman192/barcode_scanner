import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Models/HistoryItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  final HistoryItem item;
  const HistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QRController>(
      builder: (controller) {
        String svgUrl = controller.getSVGLink(item.title.toString());
        return Card(
          elevation: 3.w,
          color: Colors.white,
          child: ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w),
            ),
            onTap: (){

            },
            leading: item.category == "Barcode" ? Image.asset("assets/images/barcode.png", width: 30.w,) : svgUrl.isEmpty ? Image.asset("assets/images/qr.png", width: 30.w,) : SvgPicture.asset(svgUrl, width: 30.w,),
            title: Text("${item.data}"),
            subtitle: Text(DateFormat("EEE, dd MMM yyyy, hh:mm aa").format(item.date ?? DateTime.now())),
          ),
        );
      }
    );
  }
}
