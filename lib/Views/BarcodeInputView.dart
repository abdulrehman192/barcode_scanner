import 'dart:io';

import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Controllers/SettingsController.dart';
import 'package:barcode_scanner/Widgets/InputField.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class BarcodeInputView extends StatelessWidget {
  final String title;
  const BarcodeInputView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title QR Generator"),
      ),
      body: GetBuilder<QRController>(
        builder: (controller)
        {
          return ListView(
            padding: EdgeInsets.all(10.w),
            children: [
              InputField(
                  controller: controller.inputController,
                  hintText: controller.hintText,
                  labelText: title,
                  keyboard: title == "Aztec" || title == "PDF 417" || title == "Code 128" || title == "Code 93" || title == "Code 39" ? TextInputType.text : TextInputType.number,
                  textCapitalization: title == "Code 93" || title == "Code 39" ? TextCapitalization.characters : TextCapitalization.none,
              ),
              SizedBox(height: 15.h,),
              ElevatedButton(
                onPressed: ()async{
                 if(controller.inputController.text.trim().isEmpty)
                   {
                    controller.showSnackBar(title: "Data Required", message: "Please Enter Text To Generate Code");
                   }
                 else
                   {
                     SettingsController settings = Get.find();
                     if(settings.autoCopy)
                       {
                         await Clipboard.setData( ClipboardData(text: controller.inputController.text.trim()));
                       }
                     if(title == "Aztec" || title == "Code 128")
                       {
                         if(controller.inputController.text.trim().contains(" "))
                           {
                             controller.generated = false;
                             controller.showSnackBar(title: "Error", message: controller.hintText);
                           }
                         else
                           {
                             controller.saveBarcodeCreateHistoryItem(title);
                             controller.generated = true;
                           }
                       }
                     else if(title == "PDF 417")
                       {
                         controller.saveBarcodeCreateHistoryItem(title);
                         controller.generated = true;
                       }
                     else if(title == "EAN-13")
                       {
                         if(controller.inputController.text.trim().length != 12)
                           {
                             controller.generated = false;
                             controller.showSnackBar(title: "Error", message: controller.hintText);
                           }
                         else
                           {
                             controller.saveBarcodeCreateHistoryItem(title);
                             controller.generated = true;
                           }
                       }
                     else if(title == "EAN-8" || title == "UPC-E")
                     {
                       if(controller.inputController.text.trim().length != 7)
                       {
                         controller.generated = false;
                         controller.showSnackBar(title: "Error", message: controller.hintText);
                       }
                       else
                       {
                         controller.saveBarcodeCreateHistoryItem(title);
                         controller.generated = true;
                       }
                     }
                     else if(title == "Codabar")
                       {
                         controller.saveBarcodeCreateHistoryItem(title);
                         controller.generated = true;
                       }
                     else if(title == "UPC-A")
                     {
                       if(controller.inputController.text.trim().length != 11)
                       {
                         controller.generated = false;
                         controller.showSnackBar(title: "Error", message: controller.hintText);
                       }
                       else
                       {
                         controller.saveBarcodeCreateHistoryItem(title);
                         controller.generated = true;
                       }
                     }
                     else if(title == "Code 93" || title == "Code 39")
                     {
                       controller.saveBarcodeCreateHistoryItem(title);
                       controller.generated = true;
                     }
                     else if(title == "ITF")
                     {
                       int length = controller.inputController.text.trim().length;

                       if(length % 2 == 0)
                       {
                         controller.saveBarcodeCreateHistoryItem(title);
                         controller.generated = true;
                       }
                       else
                       {
                         controller.generated = false;
                         controller.showSnackBar(title: "Error", message: controller.hintText);
                       }
                     }
                   }
                },
                child: const Text("Generate"),
              ),
              SizedBox(height: 30.h,),
              controller.generated ?
              Column(
                children: [
                  Screenshot(
                    controller: controller.screenshotController,
                    child: Container(
                      width: 1.sw,
                      padding: EdgeInsets.all(8.w),
                      alignment: Alignment.center,
                      color: Colors.white,
                      child:  BarcodeWidget(
                        barcode: controller.getBarcodeType(title),
                        data: controller.inputController.text,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Card(
                    child: ListTile(
                      onTap: () async{
                        await Share.share(controller.inputController.text.trim());
                      },
                      leading: const CircleAvatar(child: Icon(Icons.share)),
                      title: const Text("Share as Text"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () async{
                        await Clipboard.setData(ClipboardData(text: controller.inputController.text));
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
                            String path = "${dir.path}/barcode.png";
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
                            String path = "/storage/emulated/0/Download/barcode-$date.png";
                            File image = File(path);
                            await image.writeAsBytes(bytes);
                            controller.showSnackBar(title: "Image Saved", message: "Barcode successfully saved as image");
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
              ) : const SizedBox.shrink(),
              SizedBox(height: 30.h,),
            ],
          );
        },
      ),
    );
  }
}
