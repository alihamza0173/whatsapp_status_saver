package com.devzeal.status_saver

import android.app.Activity
import android.content.Intent
import android.media.MediaScannerConnection
import android.net.Uri
import android.os.Bundle
import android.provider.MediaStore
import android.content.ContentResolver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.devzeal.filePicker"
    private lateinit var resultCallback: MethodChannel.Result
    private val OPEN_DOCUMENT_TREE_REQUEST_CODE = 42
    private var hasResult = false // Flag to check if the result has been sent

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            resultCallback = result
            when (call.method) {
                "openDocumentTree" -> {
                    if (hasMediaDirectoryAccess()) {
                        result.success(getPersistedUri())
                    } else {
                        openDocumentTree()
                    }
                }
                "scanFile" -> {
                    val filePath = call.argument<String>("path")
                    if (filePath != null) {
                        scanFile(filePath)
                    } else {
                        result.error("INVALID_ARGUMENT", "File path is null", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun hasMediaDirectoryAccess(): Boolean {
        // Check if the user has granted access to the media directory
        // This implementation assumes that access has been granted if we have a persisted URI
        val persistedUri = getPersistedUri()
        return persistedUri != null && contentResolver.persistedUriPermissions.any {
            it.uri.toString() == persistedUri
        }
    }

    private fun getPersistedUri(): String? {
        // Retrieve the persisted URI from the content resolver
        return contentResolver.persistedUriPermissions.firstOrNull()?.uri?.toString()
    }

    private fun openDocumentTree() {
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT_TREE)
        startActivityForResult(intent, OPEN_DOCUMENT_TREE_REQUEST_CODE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == OPEN_DOCUMENT_TREE_REQUEST_CODE) {
            if (resultCode == Activity.RESULT_OK) {
                val uri: Uri? = data?.data
                uri?.let {
                    contentResolver.takePersistableUriPermission(
                        uri,
                        Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
                    )
                    if (!hasResult) {
                        val uriString = uri.toString()
                        resultCallback.success(uriString)
                        hasResult = true
                    }
                } ?: run {
                    if (!hasResult) {
                        resultCallback.error("NO_URI", "No URI returned", null)
                        hasResult = true
                    }
                }
            } else {
                if (!hasResult) {
                    resultCallback.error("CANCELLED", "User cancelled the operation", null)
                    hasResult = true
                }
            }
        }
    }

    private fun scanFile(path: String) {
        MediaScannerConnection.scanFile(this, arrayOf(path), null) { scannedPath, uri ->
            if (!hasResult) {
                resultCallback.success("Scanned file: $scannedPath, URI: $uri")
                hasResult = true
            }
        }
    }
}
