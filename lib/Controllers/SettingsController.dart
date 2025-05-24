import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class SettingsController extends GetxController
{
  bool _beep = false;
  bool _autoCopy = false;
  bool _vibration = false;

  bool get beep => _beep;
  bool get autoCopy => _autoCopy;
  bool get vibration => _vibration;

  setBeep(bool val)
  {
    _beep = val;
    update();
  }

  setAutoCopy(bool val)
  {
    _autoCopy = val;
    update();
  }

  setVibration(bool val)
  {
    _vibration = val;
    update();
  }

  @override
  void onInit() {
    _initSettings();
    super.onInit();
    _loadSettings();
  }

  _initSettings()async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    var b = shared.getBool("beep");
    var c = shared.getBool("copy");
    var v = shared.getBool("vibration");
    if(b == null)
      {
        await shared.setBool("beep", true);
      }
    if(c == null)
    {
      await shared.setBool("copy", true);
    }
    if(v == null)
    {
      await shared.setBool("vibration", true);
    }
  }

  _loadSettings() async
  {
      SharedPreferences shared = await SharedPreferences.getInstance();
      _beep = shared.getBool("beep") ?? false;
      _autoCopy = shared.getBool("copy") ?? false;
      _vibration = shared.getBool("vibration") ?? false;
      update();
  }

  vibratePhone() async
  {
    bool hasVibrate = await Vibration.hasVibrator() ?? false;
    bool hasAmplitudeControl = await Vibration.hasAmplitudeControl() ?? false;
    bool hasCustomVibrationsSupport = await Vibration.hasCustomVibrationsSupport() ?? false;
    if (hasVibrate) {
      if(hasAmplitudeControl)
        {
          if(hasCustomVibrationsSupport)
            {
              Vibration.vibrate(duration: 1000);
            }
          else
            {
              Vibration.vibrate();
            }
        }
      else
      {
        Vibration.vibrate();
      }
    }
    else
    {
      Vibration.vibrate();
    }
  }
}