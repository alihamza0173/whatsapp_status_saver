package com.devzeal.status_saver

import android.media.MediaScannerConnection
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.devzeal.status_saver/fileScanner"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "scanFile") {
                val filePath = call.argument<String>("path")
                if (filePath != null) {
                    scanFile(filePath)
                    result.success("File scanned successfully: $filePath")
                } else {
                    result.error("INVALID_ARGUMENT", "File path is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun scanFile(path: String) {
        MediaScannerConnection.scanFile(this, arrayOf(path), null) { path, uri ->
            println("Scanned file: $path")
        }
    }
}
