import 'dart:io';

import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ScanResultView extends StatelessWidget {
  const ScanResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Result"),
      ),
      body: GetBuilder<QRController>(
        builder: (controller)
        {
          return ListView(
            padding: EdgeInsets.all(10.w),
            children: [
              Container(
                width: 1.sw,
                // padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      color: Colors.grey.shade200
                    ),
                    
                  ]
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 0.47.sw,
                          height: 55.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.w)),
                            color: Colors.grey
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Type", style: TextStyle(fontSize: 16.sp, color: Colors.white),),
                              Text(controller.capture!.barcodes.first.type.name, style: TextStyle(fontSize: 18.sp, color: Colors.white),)

                            ],
                          ),
                        ),
                        Container(
                          width: 0.47.sw,
                          height: 55.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8.w)),
                            color: Colors.grey
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Format", style: TextStyle(fontSize: 16.sp, color: Colors.white),),
                              Text(controller.barcode!.format == BarcodeFormat.qrCode ? "QR Code" : controller.barcode!.format.name.toUpperCase().toString(), style: TextStyle(fontSize: 18.sp, color: Colors.white),)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.all(8.w),
                         child: Column(
                           children: [
                             SizedBox(height: 5.h,),
                             controller.barcode!.format == BarcodeFormat.qrCode ?
                             Screenshot(
                               controller: controller.screenshotController,
                               child: Container(
                                 width: 0.70.sw,
                                 padding: EdgeInsets.all(8.w),
                                 alignment: Alignment.center,
                                 color: Colors.white,
                                 child: QrImageView(
                                   data: controller.inputController.text,
                                   version: QrVersions.auto,
                                   size: 150.w,
                                   gapless: true,
                                 ),
                               ),
                             ) :
                             Screenshot(
                               controller: controller.screenshotController,
                               child: Container(
                                 width: 1.sw,
                                 padding: EdgeInsets.all(8.w),
                                 alignment: Alignment.center,
                                 color: Colors.white,
                                 child: BarcodeWidget(
                                   barcode: controller.getBarcodeTypeFromScan(),
                                   data: controller.scannedData,
                                 ),
                               ),
                             ),
                             SizedBox(height: 5.h,),
                             Text(controller.scannedData, style: TextStyle(color: Colors.black, fontSize: 16.sp),)
                           ],
                         ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Card(
                child: ListTile(
                  onTap: () async{
                    await Share.share(controller.scannedData);
                  },
                  leading: const CircleAvatar(child: Icon(Icons.share)),
                  title: const Text("Share as Text"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async{
                    await Clipboard.setData(ClipboardData(text: controller.scannedData));
                    controller.showSnackBar(title: "Data Copied", message: "Data copied to the clipboard");
                  },
                  leading: const CircleAvatar(child: Icon(Icons.copy)),
                  title: const Text("Copy to clipboard"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async{
                    try {
                      Uint8List? bytes = await controller.screenshotController.capture();
                      if(bytes != null)
                      {
                        Directory dir = await getApplicationDocumentsDirectory();
                        String path = "${dir.path}/scan.png";
                        File image = File(path);
                        await image.writeAsBytes(bytes);
                        await Share.shareXFiles([XFile(path)]);
                      }
                    }
                    catch(e)
                    {
                      print(e);
                    }
                  },
                  leading: const CircleAvatar(child: Icon(Icons.share)),
                  title: const Text("Share as Image"),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () async{
                    try {
                      Uint8List? bytes = await controller.screenshotController.capture();
                      if(bytes != null)
                      {
                        int date = DateTime.now().millisecondsSinceEpoch;
                        String path = "/storage/emulated/0/Download/scan-$date.png";
                        File image = File(path);
                        await image.writeAsBytes(bytes);
                        controller.showSnackBar(title: "Image Saved", message: "Scan Data successfully saved as image");
                      }
                    }
                    catch(e)
                    {
                      print(e);
                    }
                  },
                  leading: const CircleAvatar(child: Icon(Icons.download)),
                  title: const Text("Save as Image"),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
