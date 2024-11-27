package com.example.lab6;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.BatteryManager;
import android.os.Build;
import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
public class MainActivity extends FlutterActivity {
    private static final String BATTERY_CHANNEL = "battery";
    private static final String PHONE_CHANNEL = "phone";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine){
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), BATTERY_CHANNEL).setMethodCallHandler(
                ((call, result) -> {
                    if(call.method.equals("getBatteryLevel")){
                        int batteryLevel = getBatteryLevel();
                        result.success(batteryLevel);
                    }
                    else{
                        result.notImplemented();
                    }
                })
        );

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), PHONE_CHANNEL).setMethodCallHandler(
                ((call, result) -> {
                    if(call.method.equals("callNumber")){
                        String phoneNumber = call.arguments.toString();
                        callNumber(phoneNumber);
                    }
                    else{
                        result.notImplemented();
                    }
                })
        );


    }
    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        }
        return batteryLevel;
    }

    private void callNumber(String phoneNumber){
        Intent intent = new Intent(Intent.ACTION_DIAL);
        intent.setData(Uri.parse("tel:" + phoneNumber));
        startActivity(intent);
    }



}
