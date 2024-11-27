import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "battery", binaryMessenger: controller.binaryMessenger)
    let batteryService = BatteryService()
    batteryChannel.setMethodCallHandler { (call, result) in
        batteryService.handle(call, result: result)
    }

    let phoneChannel = FlutterMethodChannel(name: "phone", binaryMessenger: controller.binaryMessenger)
    let phoneService = PhoneService()
    phoneChannel.setMethodCallHandler { (call, result) in
        phoneService.handle(call, result: result)
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
