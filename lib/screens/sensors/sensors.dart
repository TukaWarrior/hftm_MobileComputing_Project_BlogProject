import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/shared/navigation_bar.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  _SensorsScreenState createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  // Variables to store sensor data
  double _accelerometerX = 0.0, _accelerometerY = 0.0, _accelerometerZ = 0.0;
  double _gyroscopeX = 0.0, _gyroscopeY = 0.0, _gyroscopeZ = 0.0;
  double _magnetometerX = 0.0, _magnetometerY = 0.0, _magnetometerZ = 0.0;

  @override
  void initState() {
    super.initState();

    // Listen to accelerometer data
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerX = event.x;
        _accelerometerY = event.y;
        _accelerometerZ = event.z;
      });
    });

    // Listen to gyroscope data
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeX = event.x;
        _gyroscopeY = event.y;
        _gyroscopeZ = event.z;
      });
    });

    // Listen to magnetometer data
    magnetometerEvents.listen((MagnetometerEvent event) {
      setState(() {
        _magnetometerX = event.x;
        _magnetometerY = event.y;
        _magnetometerZ = event.z;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sensor Data")),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSensorDataCard(
              'Accelerometer',
              'Measures acceleration applied to the device, including the force of gravity.',
              _accelerometerX,
              _accelerometerY,
              _accelerometerZ,
            ),
            _buildSensorDataCard(
              'Gyroscope',
              'Measures the device’s rate of rotation around each of its three physical axes.',
              _gyroscopeX,
              _gyroscopeY,
              _gyroscopeZ,
            ),
            _buildSensorDataCard(
              'Magnetometer',
              'Measures the ambient geomagnetic field for all three physical axes (x, y, z) in μT (micro-Tesla).',
              _magnetometerX,
              _magnetometerY,
              _magnetometerZ,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  // Widget to display sensor data
  Widget _buildSensorDataCard(
    String sensorName,
    String description,
    double x,
    double y,
    double z,
  ) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sensorName,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(description),
            const SizedBox(height: 16.0),
            Text('X: ${x.toStringAsFixed(2)}'),
            Text('Y: ${y.toStringAsFixed(2)}'),
            Text('Z: ${z.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
