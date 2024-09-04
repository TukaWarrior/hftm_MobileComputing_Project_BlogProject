package ch.ldb.flutter_blog

import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "ch.ldb.sensors/metadata"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getSensorInfo" -> {
                        val sensorType = call.argument<Int>("sensorType") ?: Sensor.TYPE_ACCELEROMETER
                        val sensorInfo = getSensorInfo(sensorType)
                        if (sensorInfo != null) {
                            result.success(sensorInfo)
                        } else {
                            result.error("UNAVAILABLE", "Sensor not available.", null)
                        }
                    }
                    "getAvailableSensors" -> {
                        val availableSensors = getAvailableSensors()
                        result.success(availableSensors)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun getSensorInfo(sensorType: Int): Map<String, Any>? {
        val sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
        val sensor: Sensor? = sensorManager.getDefaultSensor(sensorType)
        return sensor?.let {
            mapOf(
                "name" to it.name,
                "vendor" to it.vendor,
                "version" to it.version,
                "power" to it.power,
                "resolution" to (it.resolution ?: "N/A"),  // Safely handle null resolution
                "maxRange" to (it.maximumRange ?: "N/A"),  // Safely handle null maxRange
                "minDelay" to it.minDelay
            )
        }
    }

    private fun getAvailableSensors(): List<Map<String, Any>> { // Change List type to Map<String, Any>
        val sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
        val sensorList = sensorManager.getSensorList(Sensor.TYPE_ALL)
        return sensorList.map { sensor ->
            mapOf(
                "name" to sensor.name,
                "vendor" to sensor.vendor,
                "type" to sensor.type.toString(),
                "resolution" to (sensor.resolution ?: "N/A"), // Safely handle null resolution
                "maxRange" to (sensor.maximumRange ?: "N/A")  // Safely handle null maxRange
            )
        }
    }
}
