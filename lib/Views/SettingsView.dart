import 'package:barcode_scanner/Controllers/SettingsController.dart';
import 'package:barcode_scanner/Core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SettingsController>(
        autoRemove: false,
        builder: (controller) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.music_note),
                title: Text("Beep", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),),
                subtitle: const Text("Beep when the scan is successful"),
                trailing: Switch(
                  value: controller.beep,
                  inactiveTrackColor: AppTheme.greyColor,
                  inactiveThumbColor: Colors.black,
                  onChanged: (val)async{
                    SharedPreferences shared = await SharedPreferences.getInstance();
                    await shared.setBool("beep", val);
                    controller.setBeep(val);
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.vibration),
                title: Text("Vibration", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),),
                trailing: Switch(
                  value: controller.vibration,
                  inactiveTrackColor: AppTheme.greyColor,
                  inactiveThumbColor: Colors.black,
                  onChanged: (val)async{
                    SharedPreferences shared = await SharedPreferences.getInstance();
                    await shared.setBool("vibration", val);
                    controller.setVibration(val);
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: Text("Auto copy to clipboard", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),),
                trailing: Switch(
                  value: controller.autoCopy,
                  inactiveTrackColor: AppTheme.greyColor,
                  inactiveThumbColor: Colors.black,
                  onChanged: (val)async{
                    SharedPreferences shared = await SharedPreferences.getInstance();
                    await shared.setBool("copy", val);
                    controller.setAutoCopy(val);
                  },
                ),
              ),

              SizedBox(height:10.h ,),

            ],
          );
        }
      ),
    );
  }
}
