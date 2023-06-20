import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanController extends GetxController{
  MobileScannerController scannerController = MobileScannerController();
  Barcode? barcode;
  BarcodeCapture? capture;
  MobileScannerArguments? arguments;
  bool _flashOn = false;
  String _scannedData = "";
  double _zoomScale = 0.0;

  String get scannedData => _scannedData;
  bool get flashOn => _flashOn;
  double get zoomScale => _zoomScale;

  set zoomScale(double val)
  {
    _zoomScale = val;
    update();
  }
  set scannedData(String val)
  {
    _scannedData = val;
    update();
  }

  set flashOn(bool val)
  {
    _flashOn = val;
    update();
  }

  increaseZoom(){
    if(_zoomScale < 0.9)
      {
        _zoomScale += 0.1;
        update();
      }
  }
  decreaseZoom(){
    if(_zoomScale > 0.1)
    {
      _zoomScale -= 0.1;
      update();
    }
  }


  @override
  void dispose() {
    super.dispose();
    scannerController.dispose();
  }
}
