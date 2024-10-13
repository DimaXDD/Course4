package com.example.lab4_5_tds

import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.provider.AlarmClock
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.app.ActivityManager
import android.content.Context
import android.widget.Toast

class MainActivity : FlutterActivity() {
    private val CHANNEL_BATTERY = "com.example.battery/level"
    private val CHANNEL_CPU = "com.example.cpu/load"
    private val CHANNEL_ALARM = "com.example.alarm/set"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_BATTERY).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()
                result.success(batteryLevel)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_CPU).setMethodCallHandler { call, result ->
            if (call.method == "getCpuLoad") {
                val cpuLoad = getCpuLoad()
                result.success(cpuLoad)
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_ALARM).setMethodCallHandler { call, result ->
            if (call.method == "setAlarm") {
                val hour = call.argument<Int>("hour")
                val minute = call.argument<Int>("minute")
                if (hour != null && minute != null) {
                    setAlarm(hour, minute)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENT", "Invalid hour or minute", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryIntent = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { intentFilter ->
            registerReceiver(null, intentFilter)
        }
        val level = batteryIntent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = batteryIntent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        return (level * 100) / scale
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

    private fun setAlarm(hour: Int, minute: Int) {
        val intent = Intent(AlarmClock.ACTION_SET_ALARM).apply {
            putExtra(AlarmClock.EXTRA_HOUR, hour)
            putExtra(AlarmClock.EXTRA_MINUTES, minute)
            putExtra(AlarmClock.EXTRA_MESSAGE, "Alarm set by app")
        }
        try {
            if (intent.resolveActivity(packageManager) != null) {
                startActivity(intent)
                Toast.makeText(this, "Alarm set for $hour:$minute", Toast.LENGTH_SHORT).show()
            } else {
                Toast.makeText(this, "No alarm app found", Toast.LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            Toast.makeText(this, "Error setting alarm: ${e.message}", Toast.LENGTH_SHORT).show()
            e.printStackTrace()
        }
    }

}
