import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CpuLoad {
  static const MethodChannel _channel = MethodChannel('com.example.cpu/load');

  static Future<double?> getCpuLoad() async {
    try {
      final double? cpuLoad = await _channel.invokeMethod('getCpuLoad');
      return cpuLoad;
    } on PlatformException catch (e) {
      print("Failed to get CPU load: '${e.message}'");
      return null;
    }
  }
}

class Battery {
  static const MethodChannel _channel = MethodChannel('com.example.battery/level');

  static Future<int?> getBatteryLevel() async {
    try {
      final int? batteryLevel = await _channel.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } on PlatformException catch (e) {
      print("Failed to get battery level: '${e.message}'");
      return null;
    }
  }
}

class Alarm {
  static const MethodChannel _channel = MethodChannel('com.example.alarm/set');

  static Future<void> setAlarm(int hour, int minute) async {
    try {
      await _channel.invokeMethod('setAlarm', {'hour': hour, 'minute': minute});
    } on PlatformException catch (e) {
      print("Failed to set alarm: '${e.message}'");
    }
  }
}

class Lab6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lab 6")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              double? cpuLoad = await CpuLoad.getCpuLoad();
              print("CPU Load: $cpuLoad%");
            },
            child: Text("Get CPU Load"),
          ),
          ElevatedButton(
            onPressed: () async {
              int? batteryLevel = await Battery.getBatteryLevel();
              print("Battery Level: $batteryLevel%");
            },
            child: Text("Get Battery Level"),
          ),
          ElevatedButton(
            onPressed: () async {
              await Alarm.setAlarm(7, 30);
              print("Alarm set for 7:30");
            },
            child: Text("Set Alarm"),
          ),
        ],
      ),
    );
  }
}
