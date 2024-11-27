import Flutter

public class BatteryService: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "battery", binaryMessenger: registrar.messenger())
        let instance = BatteryService()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
     public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            // Handle method calls for the phone plugin
            // Implement your logic here
        }
}

public class PhoneService: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "phone", binaryMessenger: registrar.messenger())
        let instance = PhoneService()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
     public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
            // Handle method calls for the phone plugin
            // Implement your logic here
        }
}


