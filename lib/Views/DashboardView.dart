import 'package:barcode_scanner/Controllers/DashboardController.dart';
import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Views/QRScanView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (dash) {
        String title = "QR & Barcode Scanner";
        if(dash.selectedIndex == 0)
          {
            title = "QR & Barcode Scanner";
          }
        else if(dash.selectedIndex == 1)
        {
          title = "QR & Barcode Creator";
        }
        else if(dash.selectedIndex == 2)
        {
          title = "History";
        }
        else if(dash.selectedIndex == 3)
        {
          title = "Settings";
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              dash.selectedIndex == 2 ?
                  IconButton(
                      onPressed: (){
                       Get.defaultDialog(
                         title: "Confirm Delete",
                         content: const Text("Do you want to delete all history?"),
                         actions: [
                           ElevatedButton(
                               onPressed: (){
                                 QRController con = Get.find();
                                 con.deleteHistory();
                                 Get.back();
                               },
                               child: const Text("Yes")
                           ),
                           ElevatedButton(
                               onPressed: (){
                                 Get.back();
                               },
                               child: const Text("No")
                           )
                         ]
                       );
                      },
                      icon: const Icon(Icons.delete_forever)
                  ): const SizedBox.shrink()
            ],
          ),
          body: dash.pages[dash.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.deepPurple,
            currentIndex: dash.selectedIndex,
            onTap: (i){
              dash.selectedIndex = i;
            },
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner_outlined),
                label: "Scan"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: "Create"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: "History"
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: "Settings"
              ),
            ],
          ),
        );
      }
    );
  }
}
