import 'package:flutter/material.dart';

class SensorDataCard extends StatelessWidget {
  final String sensorName;
  final String description;
  final double? x;
  final double? y;
  final double? z;
  final double? value;

  const SensorDataCard({
    super.key,
    required this.sensorName,
    required this.description,
    this.x,
    this.y,
    this.z,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
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
            if (x != null && y != null && z != null) ...[
              Text('X: ${x!.toStringAsFixed(2)}'),
              Text('Y: ${y!.toStringAsFixed(2)}'),
              Text('Z: ${z!.toStringAsFixed(2)}'),
            ],
            if (value != null) ...[
              Text('Value: ${value!.toStringAsFixed(2)}'),
            ],
          ],
        ),
      ),
    );
  }
}
