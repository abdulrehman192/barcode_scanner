import 'dart:io';

import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Widgets/InputField.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../Controllers/SettingsController.dart';

class QRInputView extends StatelessWidget {
  final String title;
  const QRInputView({super.key, required this.title});

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
                  labelText: title == 'Wi-Fi' ? 'SSID' : title,
                  keyboard: title == "Contact" || title == "Phone" || title == "Whatsapp" ? TextInputType.phone : TextInputType.url,
              ),
              title != 'Wi-Fi' ? const SizedBox():
              InputField(
                controller: controller.passwordController,
                hintText: 'Enter Wifi Password Here',
                labelText: 'Password',
                isPassword: controller.isPassword,
                trailIcon: GestureDetector(
                  onTap: (){
                    controller.isPassword = !controller.isPassword;
                  },
                  child: Icon(controller.isPassword? Icons.visibility : Icons.visibility_off),
                ),
                keyboard: TextInputType.text,
              ),
              SizedBox(height: 15.h,),
              ElevatedButton(
                onPressed: ()async{
                 if(controller.inputController.text.trim().isEmpty)
                   {
                     controller.showSnackBar(title: "Data Required", message: controller.hintText);
                   }
                 else if(title == 'Wi-Fi' && controller.passwordController.text.trim().isEmpty){
                   controller.showSnackBar(title: "Password Required", message: "Please Enter Wi-Fi Password");
                 }
                 else
                   {
                     SettingsController settings = Get.find<SettingsController>();
                     if(settings.autoCopy)
                     {
                       await Clipboard.setData( ClipboardData(text: controller.inputController.text.trim()));
                     }
                     controller.saveQRCreateHistoryItem(title);
                     controller.generated = true;
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
                      width: 0.70.sw,
                      padding: EdgeInsets.all(8.w),
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: QrImageView(
                        data: title == 'Wi-Fi' ? "WIFI:T:WPA;S:${controller.inputController.text.trim()};P:${controller.passwordController.text.trim()};;" : controller.inputController.text,
                        version: QrVersions.auto,
                        size: 200.w,
                        gapless: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  title == 'Wi-Fi' ? const SizedBox():
                  Card(
                    child: ListTile(
                      onTap: () async{
                        await Share.share(controller.inputController.text.trim());
                      },
                      leading: const CircleAvatar(child: Icon(Icons.share)),
                      title: const Text("Share as Text"),
                    ),
                  ),
                  title == 'Wi-Fi' ? const SizedBox():
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
                              String path = "${dir.path}/qr.png";
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
                            String path = "/storage/emulated/0/Download/qr-$date.png";
                            File image = File(path);
                            await image.writeAsBytes(bytes);
                            controller.showSnackBar(title: "Image Saved", message: "QR successfully saved as image");
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

            ],
          );
        },
      ),
    );
  }
}
