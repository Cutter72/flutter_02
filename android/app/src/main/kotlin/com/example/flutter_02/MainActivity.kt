package com.example.flutter_02

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

private const val CHANNEL = "myChannel"

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getDisplayMetrics") {
                val dpi = getDisplayMetrics()
                if (dpi.length > 0) {
                    result.success(dpi)
                } else {
                    result.error("UNAVAILABLE", "DPI=$dpi", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getDisplayMetrics(): String {
        return "xDpi=${resources.displayMetrics.xdpi},\n" +
                "yDpi=${resources.displayMetrics.xdpi},\n" +
                "density=${resources.displayMetrics.density},\n" +
                "densityDpi=${resources.displayMetrics.densityDpi},\n" +
                "scaledDensity=${resources.displayMetrics.scaledDensity},\n" +
                "widthPixels=${resources.displayMetrics.widthPixels},\n" +
                "heightPixels=${resources.displayMetrics.heightPixels},\n" +
                ""
    }

}
