import 'package:barcode_scanner/Views/HistoryView.dart';
import 'package:barcode_scanner/Views/QRCreateView.dart';
import 'package:barcode_scanner/Views/QRScanView.dart';
import 'package:barcode_scanner/Views/SettingsView.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController
{
  int _selectedIndex = 0;
  final pages = const [
    QRScanView(),
    QRCreateView(),
    HistoryView(),
    SettingsView()
  ];
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int val)
  {
    _selectedIndex = val;
    update();
  }
}