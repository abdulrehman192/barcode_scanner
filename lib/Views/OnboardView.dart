import 'package:barcode_scanner/Core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashboardView.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70.h,),
            Text("Point your camera at QR Code", style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
            SizedBox(height: 20.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.w,
              children: [
                CircleAvatar(
                  radius: 12.r,
                  child: Text('1', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),),

                ),
                Flexible(child: Text("Avoid light reflections or shadows on the code.", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),)),
              ],
            ),
            SizedBox(height: 10.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.w,
              children: [
                CircleAvatar(
                  radius: 12.r,
                  child: Text('2', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),),

                ),
                Flexible(child: Text("Make your phone face the code without tilting.", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),)),
              ],
            ),
            SizedBox(height: 10.h,),
            const Spacer(),
            Image.asset("assets/images/tip.jpeg"),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 0.80.sw,
                child: ElevatedButton(
                  onPressed: ()async{
                    SharedPreferences share = await SharedPreferences.getInstance();
                    share.setBool("tip", true);
                    Get.offAll(() => const DashboardView());
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppTheme.primaryColor)
                  ),
                  child: Text("Continue",  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
    );
  }
}
