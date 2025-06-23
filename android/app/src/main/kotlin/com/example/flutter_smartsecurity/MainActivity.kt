package com.example.flutter_smartsecurity

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.telephony.SmsManager
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.smartsecurity/sms"
    private val SMS_PERMISSION_CODE = 1001
    private val CALL_PERMISSION_CODE = 1002

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "sendSms" -> {
                    val phoneNumber = call.argument<String>("phoneNumber")
                    val message = call.argument<String>("message")

                    if (ContextCompat.checkSelfPermission(this, Manifest.permission.SEND_SMS)
                        != PackageManager.PERMISSION_GRANTED
                    ) {
                        ActivityCompat.requestPermissions(
                            this,
                            arrayOf(Manifest.permission.SEND_SMS),
                            SMS_PERMISSION_CODE
                        )
                        result.error("PERMISSION_DENIED", "SMS permission not granted", null)
                        return@setMethodCallHandler
                    }

                    try {
                        val smsManager = SmsManager.getDefault()
                        smsManager.sendTextMessage(phoneNumber, null, message, null, null)
                        result.success("SMS sent")
                    } catch (e: Exception) {
                        result.error("SMS_FAILED", "Failed to send SMS: ${e.message}", null)
                    }
                }

                "makeCall" -> {
                    val phoneNumber = call.argument<String>("phoneNumber")
                    if (ContextCompat.checkSelfPermission(this, Manifest.permission.CALL_PHONE)
                        != PackageManager.PERMISSION_GRANTED
                    ) {
                        ActivityCompat.requestPermissions(
                            this,
                            arrayOf(Manifest.permission.CALL_PHONE),
                            CALL_PERMISSION_CODE
                        )
                        result.error("PERMISSION_DENIED", "Call permission not granted", null)
                        return@setMethodCallHandler
                    }

                    try {
                        val callIntent = Intent(Intent.ACTION_CALL)
                        callIntent.data = Uri.parse("tel:$phoneNumber")
                        startActivity(callIntent)
                        result.success("Call started")
                    } catch (e: Exception) {
                        result.error("CALL_FAILED", "Failed to make call: ${e.message}", null)
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}
