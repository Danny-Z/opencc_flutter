package com.viptools.opencc_plugin

import android.content.Context
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import com.zqc.opencc.android.lib.ChineseConverter
import com.zqc.opencc.android.lib.ConversionType
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.concurrent.Executors


/** OpenccPlugin */
class OpenccPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    private val executor = Executors.newSingleThreadExecutor()
    private val handler = Handler(Looper.getMainLooper())

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "opencc_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        executor.execute {
            try {
                if (call.method == "convert") {
                    val originalText: String = call.argument("text")!!
                    val config: String = call.argument("config")!!

                    var conversionType = when (config) {
                        "t2s" -> ConversionType.T2S
                        "s2tw" -> ConversionType.S2TW
                        "s2twp" -> ConversionType.S2TWP
                        "s2hk" -> ConversionType.S2HK
                        "tw2s" -> ConversionType.TW2S
                        "tw2sp" -> ConversionType.TW2SP
                        "t2hk" -> ConversionType.T2HK
                        "t2tw" -> ConversionType.T2TW
                        else -> {
                            ConversionType.S2T
                        }
                    }
                    val res = ChineseConverter.convert(originalText, conversionType, context)
                    handler.post {
                        result.success(res)
                    }
                } else {
                    handler.post {
                        result.notImplemented()
                    }
                }
            } catch (t: Throwable) {
                t.printStackTrace()
                handler.post {
                    result.error(t.message ?: t.javaClass.simpleName, null, null)
                }
            }
        }

    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}

