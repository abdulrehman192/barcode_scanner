import 'package:barcode_scanner/Views/DashboardView.dart';
import 'package:barcode_scanner/Views/OnboardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  _showNext() async
  {
    SharedPreferences shared = await SharedPreferences.getInstance();
    bool tip = shared.getBool("tip") ?? false;
    Future.delayed(const Duration(seconds: 2), (){
      if(tip){
        Get.offAll(() => const DashboardView());
      }
      else
        {
          Get.offAll(() => const OnboardView());
        }
    });
  }

  @override
  void initState() {
    super.initState();
    _showNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset("assets/images/logo.png", width: 100.w,),
              SizedBox(height: 15.h,),
              Text("Scanify", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),),
              Text("Scan & Generate with ease", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),),
              const Spacer(),
              const CircularProgressIndicator(),
              SizedBox(height: 25.h,),
            ],
          ),
        ),
      ),
    );
  }
}
