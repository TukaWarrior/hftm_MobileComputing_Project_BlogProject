import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/sensors/sensordatacard.dart';
import 'package:flutter_blog/screens/shared/navigation_bar.dart';
import 'package:flutter_blog/services/sensors.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorsScreen extends StatefulWidget {
  const SensorsScreen({super.key});

  @override
  _SensorsScreenState createState() => _SensorsScreenState();
}

class _SensorsScreenState extends State<SensorsScreen> {
  final AccelerometerSensor _accelerometerSensor = AccelerometerSensor();
  final UserAccelerometerSensor _userAccelerometerSensor = UserAccelerometerSensor();
  final GyroscopeSensor _gyroscopeSensor = GyroscopeSensor();
  final MagnetometerSensor _magnetometerSensor = MagnetometerSensor();
  final BarometerSensor _barometerSensor = BarometerSensor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sensor Data"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSensorCard<AccelerometerEvent>(
              stream: _accelerometerSensor.getAccelerometerStream(),
              sensorName: 'Accelerometer',
              description: 'Measures acceleration applied to the device, including the force of gravity.',
            ),
            _buildSensorCard<UserAccelerometerEvent>(
              stream: _userAccelerometerSensor.getUserAccelerometerStream(),
              sensorName: 'User Accelerometer',
              description: 'Measures acceleration applied to the device, excluding the force of gravity.',
            ),
            _buildSensorCard<GyroscopeEvent>(
              stream: _gyroscopeSensor.getGyroscopeStream(),
              sensorName: 'Gyroscope',
              description: 'Measures the device’s rate of rotation around each of its three physical axes.',
            ),
            _buildSensorCard<MagnetometerEvent>(
              stream: _magnetometerSensor.getMagnetometerStream(),
              sensorName: 'Magnetometer',
              description: 'Measures the ambient geomagnetic field for all three physical axes (x, y, z) in μT (micro-Tesla).',
            ),
            _buildSensorCard<BarometerEvent>(
              stream: _barometerSensor.getBarometerStream(),
              sensorName: 'Barometer',
              description: 'Measures the atmospheric pressure in hPa (hectopascal).',
              isSingleValue: true,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget _buildSensorCard<T>({
    required Stream<T> stream,
    required String sensorName,
    required String description,
    bool isSingleValue = false,
  }) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;

          // Handle BarometerEvent separately
          if (isSingleValue && data is BarometerEvent) {
            return SensorDataCard(
              sensorName: sensorName,
              description: description,
              value: data.pressure,
            );
          }
          // Handle events with x, y, z values (AccelerometerEvent, GyroscopeEvent, MagnetometerEvent, UserAccelerometerEvent)
          else if (data is AccelerometerEvent) {
            return SensorDataCard(
              sensorName: sensorName,
              description: description,
              x: data.x,
              y: data.y,
              z: data.z,
            );
          } else if (data is UserAccelerometerEvent) {
            return SensorDataCard(
              sensorName: sensorName,
              description: description,
              x: data.x,
              y: data.y,
              z: data.z,
            );
          } else if (data is GyroscopeEvent) {
            return SensorDataCard(
              sensorName: sensorName,
              description: description,
              x: data.x,
              y: data.y,
              z: data.z,
            );
          } else if (data is MagnetometerEvent) {
            return SensorDataCard(
              sensorName: sensorName,
              description: description,
              x: data.x,
              y: data.y,
              z: data.z,
            );
          }
        }
        return _buildLoadingSensorCard(sensorName);
      },
    );
  }

  // Widget to display loading card for sensors
  Widget _buildLoadingSensorCard(String sensorName) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Loading $sensorName data...',
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
