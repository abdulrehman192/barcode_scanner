import 'dart:io';
import 'package:barcode_scanner/Controllers/QRController.dart';
import 'package:barcode_scanner/Controllers/SettingsController.dart';
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
  const QRScanView({Key? key}) : super(key: key);

  @override
  State<QRScanView> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<QRScanView> {


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
                fit: BoxFit.fill,
                scanWindow: scanWindow,
                controller: con.scannerController,
                onScannerStarted: (arguments) {
                  setState(() {
                    con.arguments = arguments;
                  });
                },
                onDetect: (BarcodeCapture barcode) async {
                  SettingsController settings = Get.find();
                  con.capture = barcode;
                  if(barcode.barcodes.isNotEmpty)
                  {

                    if(settings.beep)
                    {
                      FlutterRingtonePlayer.play(fromAsset: "assets/audios/beep.wav");
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
                  con.barcode?.corners != null &&
                  con.arguments != null)
                CustomPaint(
                  painter: BarcodeOverlay(
                    barcode: con.barcode!,
                    arguments: con.arguments!,
                    boxFit: BoxFit.contain,
                    capture: con.capture!,
                  ),
                ),
                CustomPaint(
                painter: ScannerOverlay(scanWindow),
                ),

              Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
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
                              color: Colors.grey.withOpacity(0.6),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.w), bottomLeft: Radius.circular(8.w))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(con.flashOn ? Icons.flash_off : Icons.flash_on , size: 27.h, color: Colors.white,),
                                Text("Light", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),)
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
                                bool a = await con.scannerController.analyzeImage(x.path);
                                if(a){
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
                                color: Colors.grey.withOpacity(0.6),
                                // borderRadius: BorderRadius.only(topLeft: Radius.circular(8.w), bottomLeft: Radius.circular(8.w))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo_library , size: 27.h, color: Colors.white,),
                                Text("Scan Image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12.sp),)
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
                                color: Colors.grey.withOpacity(0.6),
                                borderRadius: BorderRadius.only(topRight: Radius.circular(8.w), bottomRight: Radius.circular(8.w))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.flip_camera_ios , size: 27.h, color: Colors.white,),
                                Text("Change Camera", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold , fontSize: 12.sp),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
              Positioned(
                // padding: EdgeInsets.only(bottom: 10.h),
                bottom: 100.h,
                left: 10.w,
                right: 10.w,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: ()async{
                          con.decreaseZoom();
                          await con.scannerController.setZoomScale(con.zoomScale);
                        },
                        splashRadius: 20,
                        icon: const Icon(Icons.zoom_out, color: Colors.white,),
                      ),
                      Expanded(
                          child: Slider(
                            value: con.zoomScale,
                            onChanged: (val)
                            {
                              con.zoomScale = val;
                              con.scannerController.setZoomScale(val);
                            },
                          )
                      ),
                      IconButton(
                        onPressed: ()async{
                          con.increaseZoom();
                          await con.scannerController.setZoomScale(con.zoomScale);
                        },
                        splashRadius: 20,
                        icon: const Icon(Icons.zoom_in, color: Colors.white,),
                      )
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
    required this.arguments,
    required this.boxFit,
    required this.capture,
  });

  final BarcodeCapture capture;
  final Barcode barcode;
  final MobileScannerArguments arguments;
  final BoxFit boxFit;

  @override
  void paint(Canvas canvas, Size size) {
    if (barcode.corners == null) return;
    final adjustedSize = applyBoxFit(boxFit, arguments.size, size);

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
        (Platform.isIOS ? capture.width! : arguments.size.width) /
            adjustedSize.destination.width;
    final ratioHeight =
        (Platform.isIOS ? capture.height! : arguments.size.height) /
            adjustedSize.destination.height;

    final List<Offset> adjustedOffset = [];
    for (final offset in barcode.corners!) {
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