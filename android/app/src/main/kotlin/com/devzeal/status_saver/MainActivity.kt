package com.devzeal.status_saver
import android.content.pm.PackageManager
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "app_check"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "isAppInstalled") {
                    val packageName = call.argument<String>("packageName")
                    val installed = isAppInstalled(packageName)
                    result.success(installed)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun isAppInstalled(packageName: String?): Boolean {
        val packageManager = packageManager
        val intent = packageManager.getLaunchIntentForPackage(packageName!!)
        return intent != null
    }
}

