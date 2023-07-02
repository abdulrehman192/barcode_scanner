
import 'package:barcode_scanner/Models/HistoryItem.dart';
import 'package:barcode_scanner/Services/SQLiteService.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:screenshot/screenshot.dart';
import '../Models/QRCreateItem.dart';
import 'package:barcode_widget/barcode_widget.dart' as bar;
class QRController extends GetxController{
  final db = SQLiteService.instance;
  MobileScannerController scannerController = MobileScannerController();
  final inputController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  Barcode? barcode;
  bool _isNumberInput = false;
  bool _generated = false;
  String _hintText = "Enter Text here to generate Code";
  BarcodeCapture? capture;
  MobileScannerArguments? arguments;
  bool _flashOn = false;
  String _scannedData = "";
  double _zoomScale = 0.0;
  static List<HistoryItem> _historyItems = [];
  List<HistoryItem> _scanHistoryItems = [];
  List<HistoryItem> get scanHistoryItems => _scanHistoryItems;
  List<HistoryItem> _createHistoryItems = [];
  List<HistoryItem> get createHistoryItems => _createHistoryItems;
  String get scannedData => _scannedData;
  String get hintText => _hintText;
  bool get flashOn => _flashOn;
  bool get generated => _generated;
  bool get isNumberInput => _isNumberInput;
  double get zoomScale => _zoomScale;

  List<QRCreateItem> createList = [
    QRCreateItem(
      title: "Clipboard",
      imageUrl: "assets/images/clipboard.svg"
    ),
    QRCreateItem(
        title: "Website",
        imageUrl: "assets/images/website.svg"
    ),
    QRCreateItem(
        title: "Wi-Fi",
        imageUrl: "assets/images/wifi.svg"
    ),
    QRCreateItem(
        title: "Facebook",
        imageUrl: "assets/images/facebook.svg"
    ),
    QRCreateItem(
        title: "Youtube",
        imageUrl: "assets/images/youtube.svg"
    ),
    QRCreateItem(
        title: "Whatsapp",
        imageUrl: "assets/images/whatsapp.svg"
    ),
    QRCreateItem(
        title: "Text",
        imageUrl: "assets/images/text.svg"
    ),
    QRCreateItem(
        title: "Contact",
        imageUrl: "assets/images/contact.svg"
    ),
    QRCreateItem(
        title: "Tel",
        imageUrl: "assets/images/phone.svg"
    ),
    QRCreateItem(
        title: "Email",
        imageUrl: "assets/images/email.svg"
    ),
    QRCreateItem(
        title: "SMS",
        imageUrl: "assets/images/sms.svg"
    ),
    QRCreateItem(
        title: "My Card",
        imageUrl: "assets/images/card.svg"
    ),
    QRCreateItem(
        title: "Paypal",
        imageUrl: "assets/images/paypal.svg"
    ),
    QRCreateItem(
        title: "Instagram",
        imageUrl: "assets/images/instagram.svg"
    ),
    QRCreateItem(
        title: "Viber",
        imageUrl: "assets/images/viber.svg"
    ),
    QRCreateItem(
        title: "Twitter",
        imageUrl: "assets/images/twitter.svg"
    ),
    QRCreateItem(
        title: "Calendar",
        imageUrl: "assets/images/calendar.svg"
    ),
    QRCreateItem(
        title: "Spotify",
        imageUrl: "assets/images/spotify.svg"
    ),
  ];

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

  set generated(bool val)
  {
    _generated = val;
    update();
  }

  set isNumberInput(bool val)
  {
    _isNumberInput = val;
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
    _generated = false;
  }


  updateHintText(String title)
  {
    if(title == "Text" || title == "Contact" || title == "Tel" || title == "Email" || title == "SMS" || title == "My Card" )
      {
        _hintText = "Enter $title here to generate code";
      }
    else if(title == "Wi-Fi")
      {
        _hintText = "Enter Wi-Fi Name Here";
      }
    else if(title == "Facebook" || title == "Youtube" || title == "Website" || title == "Email" || title == "Paypal" || title == "Instagram" || title == "Viber" || title == "Twitter" || title == "Calendar" || title == "Spotify")
      {
        _hintText = "Enter $title link here";
      }
    else if(title == "Whatsapp")
      {
        _hintText = "Enter Whatsapp number with country code here";
      }
    else
      {
        _hintText = "Enter Text here to generate Code";
      }
    update();
  }

  barcodeHint(String title)
  {
    if(title == "Aztec")
      {
        _hintText = "Enter Text without spaces";
      }
    else if(title == "PDF 417")
    {
      _hintText = "Enter Text Here";
    }
    else if(title == "EAN-13")
    {
      _hintText = "Enter 12 Digits Here";
    }
    else if(title == "EAN-8")
    {
      _hintText = "Enter 7 Digits Here";
    }
    else if(title == "UPC-E")
    {
      _hintText = "Enter 7 Digits Here";
    }
    else if(title == "UPC-A")
    {
      _hintText = "Enter 11 Digits Here";
    }
    else if(title == "Code 128")
    {
      _hintText = "Enter Text without spaces";
    }
    else if(title == "Code 93")
    {
      _hintText = "Enter Text in upper case without spaces";
    }
    else if(title == "Code 39")
    {
      _hintText = "Enter Text in upper case without spaces";
    }
    else if(title == "Codabar")
    {
      _hintText = "Enter Digits Here";
    }
    else if(title == "ITF")
    {
      _hintText = "Enter Text in even length";
    }
    update();
  }

  showSnackBar({required String title, required String message})
  {
    GetSnackBar snackbar = GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 2),
    );
    Get.showSnackbar(snackbar);
  }


  bar.Barcode getBarcodeType(String title)
  {
    if(title == "Aztec")
    {
      return bar.Barcode.aztec();
    }
    else if(title == "PDF 417")
    {
      return bar.Barcode.pdf417();
    }
    else if(title == "EAN-13")
    {
      return bar.Barcode.ean13();
    }
    else if(title == "EAN-8")
    {
      return bar.Barcode.ean8();
    }
    else if(title == "UPC-E")
    {
      return bar.Barcode.upcE();
    }
    else if(title == "UPC-A")
    {
      return bar.Barcode.upcA();
    }
    else if(title == "Code 128")
    {
      return bar.Barcode.code128();
    }
    else if(title == "Code 93")
    {
      return bar.Barcode.code93();
    }
    else if(title == "Code 39")
    {
      return bar.Barcode.code39();
    }
    else if(title == "Codabar")
    {
      return bar.Barcode.codabar();
    }
    else if(title == "ITF")
    {
      return bar.Barcode.itf();
    }
    else
      {
        return bar.Barcode.pdf417();
      }
  }

  saveBarcodeCreateHistoryItem(String title) async
  {
    String query = "Insert into history (title, type, data, category, date) values ('$title', 'Create', '${inputController.text}', 'Barcode', '${DateTime.now().millisecondsSinceEpoch}')";
    await db.rawInsert(query: query);
    await getHistoryItems();
  }

  saveScanHistoryItem(String title, String category) async
  {
    String query = "Insert into history (title, type, data, category, date) values ('$title', 'Scan', '$_scannedData', '$category', '${DateTime.now().millisecondsSinceEpoch}')";
    await db.rawInsert(query: query);
    await getHistoryItems();
  }

  saveQRCreateHistoryItem(String title) async
  {
    String query = "Insert into history (title, type, data, category, date) values ('$title', 'Create', '${inputController.text}', 'QR', '${DateTime.now().millisecondsSinceEpoch}')";
    await db.rawInsert(query: query);
    await getHistoryItems();
  }

  @override
  onInit()
  {
    super.onInit();
    getHistoryItems();
  }

  getHistoryItems() async
  {
    String query = "Select * from history";
    var data = await db.rawQuery(query: query);
    _historyItems = data.map((e) => HistoryItem.fromMap(e)).toList();
    _scanHistoryItems = _historyItems.where((element) => element.type == "Scan").toList();
    _createHistoryItems = _historyItems.where((element) => element.type == "Create").toList();
    update();
  }

  String getSVGLink(String title)
  {
    var x = createList.where((element) => element.title == title).toList();
    if(x.isNotEmpty)
      {
        return x.first.imageUrl;
      }
    else
      {
        return "";
      }
  }


  bar.Barcode getBarcodeTypeFromScan()
  {
    if(barcode != null)
      {
        if(barcode!.format == BarcodeFormat.aztec)
        {
          return bar.Barcode.aztec();
        }
        else if(barcode!.format == BarcodeFormat.pdf417)
        {
          return bar.Barcode.pdf417();
        }
        else if(barcode!.format == BarcodeFormat.ean13)
        {
          return bar.Barcode.ean13();
        }
        else if(barcode!.format == BarcodeFormat.ean8)
        {
          return bar.Barcode.ean8();
        }
        else if(barcode!.format == BarcodeFormat.upcE)
        {
          return bar.Barcode.upcE();
        }
        else if(barcode!.format == BarcodeFormat.upcA)
        {
          return bar.Barcode.upcA();
        }
        else if(barcode!.format == BarcodeFormat.code128)
        {
          return bar.Barcode.code128();
        }
        else if(barcode!.format == BarcodeFormat.code93)
        {
          return bar.Barcode.code93();
        }
        else if(barcode!.format == BarcodeFormat.code39)
        {
          return bar.Barcode.code39();
        }
        else if(barcode!.format == BarcodeFormat.codebar)
        {
          return bar.Barcode.codabar();
        }
        else if(barcode!.format == BarcodeFormat.itf)
        {
          return bar.Barcode.itf();
        }
        else
        {
          return bar.Barcode.pdf417();
        }

      }
    else
    {
      return bar.Barcode.pdf417();
    }
  }

  void deleteHistory()async {
    await db.rawDelete(query: "Delete from history");
    await getHistoryItems();
  }

}
