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
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70.h,),
            Text("Point your camera at code to auto scan", style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.w700),),
            SizedBox(height: 10.h,),
            Text("1- Avoid light reflections or shadows on the code.", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),),
            SizedBox(height: 10.h,),
            Text("2- Make your phone face the code without tilting.", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),),
            SizedBox(height: 10.h,),
            const Spacer(),
            Image.asset("assets/images/tip.jpeg"),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 0.60.sw,
                child: ElevatedButton(
                  onPressed: ()async{
                    SharedPreferences share = await SharedPreferences.getInstance();
                    share.setBool("tip", true);
                    Get.offAll(() => const DashboardView());
                  },
                  child: const Text("Next"),
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
