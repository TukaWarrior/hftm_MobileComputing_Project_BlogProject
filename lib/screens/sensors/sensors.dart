import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  _SensorsScreenState createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  static const platform = MethodChannel('com.example.sensors/metadata');
  String sensorInfo = 'Unknown';

  @override
  void initState() {
    super.initState();
    _getAvailableSensors();
    // Uncomment the line below to get info for a specific sensor, like the accelerometer.
    // _getSensorInfo(SensorType.accelerometer);
  }

  Future<void> _getSensorInfo(SensorType sensorType) async {
    try {
      final Map<String, dynamic> result = await platform.invokeMethod('getSensorInfo', {
        'sensorType': sensorType.index,
      });
      setState(() {
        sensorInfo = result.entries.map((entry) => "${entry.key}: ${entry.value}").join("\n");
      });
    } on PlatformException catch (e) {
      setState(() {
        sensorInfo = "Failed to get sensor info: '${e.message}'.";
      });
    }
  }

  Future<void> _getAvailableSensors() async {
    try {
      final List<dynamic> sensors = await platform.invokeMethod('getAvailableSensors');
      setState(() {
        sensorInfo = sensors.map((sensor) {
          return "Name: ${sensor['name']}\nVendor: ${sensor['vendor']}\nType: ${sensor['type']}";
        }).join("\n\n");
      });
    } on PlatformException catch (e) {
      setState(() {
        sensorInfo = "Failed to get sensor info: '${e.message}'.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sensor Metadata")),
      body: Center(
        child: Text(sensorInfo, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}

enum SensorType {
  accelerometer,
  gyroscope,
  magnetometer,
  // Add more sensors as needed
}
