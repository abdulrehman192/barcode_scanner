import 'package:barcode_scanner/Core/app_theme.dart';
import 'package:barcode_scanner/Widgets/CreateBarcodeCard.dart';
import 'package:barcode_scanner/Widgets/CreateQRCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../Controllers/QRController.dart';

class QRCreateView extends StatefulWidget {
  const QRCreateView({super.key});

  @override
  State<QRCreateView> createState() => _QRCreateViewState();
}

class _QRCreateViewState extends State<QRCreateView> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        controller: tabController,
        indicatorColor: AppTheme.primaryColor,
        indicator: BoxDecoration(
          color: AppTheme.primaryColor
        ),
        labelColor: Colors.white,
        tabs: [
          Tab(text: "QR Code",),
          Tab(text: "Barcode",),
        ],
      ),
        body: GetBuilder<QRController>(
            builder: (controller) {
              return TabBarView(
                controller: tabController,
                children: [
                  ListView(
                    padding: EdgeInsets.all(10.w),
                    children: [
                      Text("Communication", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                      SizedBox(height: 8.h,),
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5.w,
                              mainAxisSpacing: 8.w,
                              childAspectRatio: 1/1.1
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.communicationList.length,
                          itemBuilder: (context, index)
                          {
                            return CreateQRCard(item:  controller.communicationList[index],);
                          }
                      ),
                      SizedBox(height: 8.h,),
                      Text("Social Media", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                      SizedBox(height: 8.h,),
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5.w,
                              mainAxisSpacing: 8.w,
                              childAspectRatio: 1/1.1
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.socialList.length,
                          itemBuilder: (context, index)
                          {
                            return CreateQRCard(item:  controller.socialList[index],);
                          }
                      ),
                      SizedBox(height: 8.h,),
                      Text("Business & Payments", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                      SizedBox(height: 8.h,),
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5.w,
                              mainAxisSpacing: 8.w,
                              childAspectRatio: 1/1.1
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.businessList.length,
                          itemBuilder: (context, index)
                          {
                            return CreateQRCard(item:  controller.businessList[index],);
                          }
                      ),
                      SizedBox(height: 8.h,),
                      Text("Utilities", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                      SizedBox(height: 8.h,),
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5.w,
                              mainAxisSpacing: 8.w,
                              childAspectRatio: 1/1.1
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.utilitiesList.length,
                          itemBuilder: (context, index)
                          {
                            return CreateQRCard(item:  controller.utilitiesList[index],);
                          }
                      ),
                      SizedBox(height: 8.h,),
                      Text("App Stores", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),),
                      SizedBox(height: 8.h,),
                      GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5.w,
                              mainAxisSpacing: 8.w,
                              childAspectRatio: 1/1.1
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: controller.appsList.length,
                          itemBuilder: (context, index)
                          {
                            return CreateQRCard(item:  controller.appsList[index],);
                          }
                      ),
                      SizedBox(height: 8.h,),
                    ],
                  ),
                  GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5.w,
                    mainAxisSpacing: 10.w,
                    padding: EdgeInsets.all(10.w),
                    children: const [
                      CreateBarcodeCard(
                          title: "Aztec"
                      ),
                      CreateBarcodeCard(
                          title: "PDF 417"
                      ),
                      CreateBarcodeCard(
                          title: "EAN-13"
                      ),
                      CreateBarcodeCard(
                          title: "EAN-8"
                      ),
                      CreateBarcodeCard(
                          title: "UPC-E"
                      ),
                      CreateBarcodeCard(
                          title: "UPC-A"
                      ),
                      CreateBarcodeCard(
                          title: "Code 128"
                      ),
                      CreateBarcodeCard(
                          title: "Code 93"
                      ),
                      CreateBarcodeCard(
                          title: "Code 39"
                      ),
                      CreateBarcodeCard(
                          title: "Codabar"
                      ),
                      CreateBarcodeCard(
                          title: "ITF"
                      ),
                    ],
                  )
                ],
              );
            }
        )
    );
  }
}
