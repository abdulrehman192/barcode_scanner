import 'package:barcode_scanner/Views/HomeView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  _showNext() async
  {

    Future.delayed(const Duration(seconds: 2), (){
      Get.offAll(() => const HomeView());
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/qr.png", width: 0.40.sw,),
                  Image.asset("assets/images/barcode.png", width: 0.40.sw,),
                ],
              ),
              SizedBox(height: 15.h,),
              Text("QR & Barcode Scanner", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),),
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
