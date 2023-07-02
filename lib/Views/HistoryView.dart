import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Models/HistoryItem.dart';
import 'package:barcode_scanner/Widgets/HistoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> with SingleTickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<QRController>(
        builder: (controller) {
          return Column(
            children: [
              TabBar(
               indicatorSize: TabBarIndicatorSize.tab,
                controller: tabController,
                tabs: const [
                  Tab(text: "SCAN",),
                  Tab(text: "Create",),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.all(8.w),
                        itemCount: controller.scanHistoryItems.length,
                        itemBuilder: (context, index)
                            {
                              return HistoryCard(
                                item: controller.scanHistoryItems[index],
                              );
                            }
                    ),
                    ListView.builder(
                        padding: EdgeInsets.all(8.w),
                        itemCount: controller.createHistoryItems.length,
                        itemBuilder: (context, index)
                        {
                          return HistoryCard(
                            item: controller.createHistoryItems[index],
                          );
                        }
                    )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
