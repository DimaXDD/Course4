package com.example.lab4_5

import android.content.Intent
import android.net.Uri
import android.bluetooth.BluetoothAdapter
import android.content.IntentFilter
import android.os.BatteryManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.RandomAccessFile
import android.app.ActivityManager
import android.content.Context
import android.os.Debug

class MainActivity : FlutterActivity() {
    private val CHANNEL_BLUETOOTH = "com.example.bluetooth/status"
    private val CHANNEL_BROWSER = "com.example.browser/launch"
    private val CHANNEL_BATTERY = "com.example.battery/level"
    private val CHANNEL_CPU = "com.example.cpu/load" // Добавьте эту строку

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Метод канала для статуса Bluetooth
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_BLUETOOTH).setMethodCallHandler { call, result ->
            if (call.method == "getBluetoothStatus") {
                val status = getBluetoothStatus()
                result.success(status)
            } else {
                result.notImplemented()
            }
        }

        // Метод канала для запуска браузера
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_BROWSER).setMethodCallHandler { call, result ->
            if (call.method == "launchBrowser") {
                val url = call.argument<String>("url")
                if (url != null) {
                    launchBrowser(url)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "URL is null", null)
                }
            } else {
                result.notImplemented()
            }
        }

        // Метод канала для получения уровня заряда батареи
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_BATTERY).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                result.success(batteryLevel)
            } else {
                result.notImplemented()
            }
        }

        // Метод канала для получения информации о загрузке процессора
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_CPU).setMethodCallHandler { call, result ->
            if (call.method == "getCpuLoad") {
                val cpuLoad = getCpuLoad()
                result.success(cpuLoad)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBluetoothStatus(): String {
        val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
        return when {
            bluetoothAdapter == null -> "No Support"
            bluetoothAdapter.isEnabled -> "Enabled"
            else -> "Disabled"
        }
    }

    private fun launchBrowser(url: String) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        startActivity(intent)
    }

    private fun getBatteryLevel(): Int {
        val batteryIntent = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { intentFilter ->
            registerReceiver(null, intentFilter)
        }
        val level = batteryIntent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = batteryIntent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        return (level * 100) / scale // Возвращаем уровень заряда как процент
    }

    private fun getCpuLoad(): Double {
        try {
            val activityManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val memoryInfo = ActivityManager.MemoryInfo()
            activityManager.getMemoryInfo(memoryInfo)

            val runtime = Runtime.getRuntime()
            val usedMem = runtime.totalMemory() - runtime.freeMemory()
            val totalMem = memoryInfo.totalMem

            return (usedMem.toDouble() / totalMem) * 100.0
        } catch (e: Exception) {
            e.printStackTrace()
            return -1.0
        }
    }
}

