import 'package:flutter/services.dart';


class BatteryService{
  static const platform = MethodChannel('battery');

  static Future<int> getBatteryLevel() async{
    try{
      final int result = await platform.invokeMethod('getBatteryLevel');
      return result;
    }
    catch(e){
      return -1;
    }
  }
}