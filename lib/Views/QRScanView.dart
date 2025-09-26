import 'dart:async';
import 'dart:io';
import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Controllers/SettingsController.dart';
import 'package:barcode_scanner/Core/app_theme.dart';
import 'package:barcode_scanner/Views/DashboardView.dart';
import 'package:barcode_scanner/Views/ScanResultView.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScanView extends StatefulWidget {
  const QRScanView({super.key});

  @override
  State<QRScanView> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<QRScanView> with WidgetsBindingObserver{

  StreamSubscription<Object?>? _subscription;
  final QRController _controller = Get.find<QRController>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!_controller.scannerController.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
      // Restart the scanner when the app is resumed.
      // Don't forget to resume listening to the barcode events.
        _subscription = _controller.scannerController.barcodes.listen(_handleBarcode);

        unawaited(_controller.scannerController.start());
      case AppLifecycleState.inactive:
      // Stop the scanner when the app is paused.
      // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controller.scannerController.stop());
    }
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
  }

  @override
  void initState() {
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = _controller.scannerController.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(_controller.scannerController.start());
    super.initState();
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    _controller.barcode = barcodes.barcodes.firstOrNull;
    _controller.update();
  }



  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromLTWH(
      0.25.sw, 0.23.sh, 200 , 200
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<QRController>(
        builder: (con) {
          return Stack(
            // alignment: Alignment.center,
            children: [
              MobileScanner(
                // fit: BoxFit.cover,
                scanWindow: scanWindow,
                controller: con.scannerController,
                onDetect: (BarcodeCapture barcode) async {
                  SettingsController settings = Get.find<SettingsController>();
                  con.capture = barcode;
                  if(barcode.barcodes.isNotEmpty)
                  {

                    if(settings.beep)
                    {
                      FlutterRingtonePlayer().play(fromAsset: "assets/audios/beep.wav");
                    }
                    if(settings.vibration)
                    {
                      settings.vibratePhone();
                    }

                    String? val = barcode.barcodes.first.displayValue;
                    if(val != null)
                    {
                      con.scannedData = val;
                      if(settings.autoCopy)
                      {
                        await Clipboard.setData( ClipboardData(text: val));
                      }
                      String category = barcode.barcodes.first.format == BarcodeFormat.qrCode ? "QR" : "Barcode";
                      con.saveScanHistoryItem("Scan", category);
                      Get.to(() => const ScanResultView());
                    }
                    con.barcode = barcode.barcodes.first;
                    con.update();
                  }

                },
              ),
              if (con.barcode != null &&
                  con.barcode?.corners != null)
                CustomPaint(
                  painter: BarcodeOverlay(
                    barcode: con.barcode!,
                    boxFit: BoxFit.contain,
                    capture: con.capture!,
                  ),
                ),
                CustomPaint(
                painter: ScannerOverlay(scanWindow),
                ),

              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 15.h,
                    children: [
                      Slider(
                        value: con.zoomScale,
                        thumbColor: AppTheme.primaryColor,
                        onChanged: (val)
                        {
                          con.zoomScale = val;
                          con.scannerController.setZoomScale(val);
                        },
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                await con.scannerController.toggleTorch();
                                con.flashOn = !con.flashOn;
                              },
                              child: Container(
                                width: 1.sw / 3.5,
                                height: 60.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryLightColor,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.w), bottomLeft: Radius.circular(8.w))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 5.h,
                                  children: [
                                    Icon(con.flashOn ? Icons.flash_off : Icons.flash_on , size: 27.h, color: Colors.white,),
                                    Text("Light", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.sp),)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 1.w,
                              height: 60.h,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              onTap: ()async{
                                final ImagePicker picker = ImagePicker();
                                var x = await picker.pickImage(source: ImageSource.gallery);
                                if(x != null)
                                  {
                                    final res = await con.scannerController.analyzeImage(x.path);
                                    if(res != null){
                                    }
                                    else
                                      {
                                        GetSnackBar snackBar = const GetSnackBar(title: "Invalid Image", message: "Image does not contains any QR or Barcode", duration: Duration(seconds: 2),);
                                        Get.showSnackbar(snackBar);
                                      }
                                  }
                              },
                              child: Container(
                                width: 1.sw / 3.5,
                                height: 60.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppTheme.primaryLightColor,
                                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(8.w), bottomLeft: Radius.circular(8.w))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 5.h,
                                  children: [
                                    Icon(Icons.photo_library , size: 27.h, color: Colors.white,),
                                    Text("Scan Image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.sp),)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 1.w,
                              height: 60.h,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              onTap: ()async{
                                await con.scannerController.switchCamera();
                              },
                              child: Container(
                                width: 1.sw / 3.5,
                                height: 60.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppTheme.primaryLightColor,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(8.w), bottomRight: Radius.circular(8.w))
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  spacing: 5.h,
                                  children: [
                                    Icon(Icons.flip_camera_ios , size: 27.h, color: Colors.white,),
                                    Text("Change Camera", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 10.sp), textAlign: TextAlign.center,)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }
}

class ScannerOverlay extends CustomPainter {
  ScannerOverlay(this.scanWindow);

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()..addRect(Rect.largest);
    final cutoutPath = Path()..addRect(scanWindow);

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BarcodeOverlay extends CustomPainter {
  BarcodeOverlay({
    required this.barcode,
    required this.boxFit,
    required this.capture,
  });

  final BarcodeCapture capture;
  final Barcode barcode;
  final BoxFit boxFit;

  @override
  void paint(Canvas canvas, Size size) {
    final adjustedSize = applyBoxFit(boxFit, size, size);

    double verticalPadding = size.height - adjustedSize.destination.height;
    double horizontalPadding = size.width - adjustedSize.destination.width;
    if (verticalPadding > 0) {
      verticalPadding = verticalPadding / 2;
    } else {
      verticalPadding = 0;
    }

    if (horizontalPadding > 0) {
      horizontalPadding = horizontalPadding / 2;
    } else {
      horizontalPadding = 0;
    }

    final ratioWidth =
        (Platform.isIOS ? capture.size.width : size.width) /
            adjustedSize.destination.width;
    final ratioHeight =
        (Platform.isIOS ? capture.size.height : size.height) /
            adjustedSize.destination.height;

    final List<Offset> adjustedOffset = [];
    for (final offset in barcode.corners) {
      adjustedOffset.add(
        Offset(
          offset.dx / ratioWidth + horizontalPadding,
          offset.dy / ratioHeight + verticalPadding,
        ),
      );
    }
    final cutoutPath = Path()..addPolygon(adjustedOffset, true);

    final backgroundPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOut;

    canvas.drawPath(cutoutPath, backgroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}