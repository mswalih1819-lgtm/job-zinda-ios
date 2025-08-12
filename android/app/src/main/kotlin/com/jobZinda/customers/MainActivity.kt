package com.jobZinda.customers

import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

/**
 * MainActivity for Job Zinda app.
 * Note: Deep link handling is currently disabled for debugging purposes.
 * The legacy deep link handling code has been removed and Firebase Dynamic Links integration is paused.
 */
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        // Log.d("Firebase Dynamic Links", "Flutter engine configured")
    }
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Log.d("Firebase Dynamic Links", "MainActivity created")
    }
    
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        // Log.d("Firebase Dynamic Links", "New intent received: ${intent.action}, data: ${intent.data}")
    }
}
