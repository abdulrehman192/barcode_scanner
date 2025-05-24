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
        body: GetBuilder<QRController>(
            builder: (controller) {
              return controller.createList.isEmpty ? const Center(child: Text("No Item Found"),) :
              Column(
                children: [
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: tabController,
                    tabs: const [
                      Tab(text: "QR Code",),
                      Tab(text: "Barcode",),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 5.w,
                                mainAxisSpacing: 10.w,
                                childAspectRatio: 1/1.1
                            ),
                            padding: EdgeInsets.all(10.w),
                            itemCount: controller.createList.length,
                            itemBuilder: (context, index)
                            {
                              return CreateQRCard(item:  controller.createList[index],);
                            }
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
                    ),
                  ),
                ],
              );
            }
        )
    );
  }
}
