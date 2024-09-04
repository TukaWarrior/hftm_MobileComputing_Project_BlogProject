import 'package:sensors_plus/sensors_plus.dart';

// Accelerometer sensor from sensors_plus.
// Accelerometers measure the velocity of the device, returning values in meters per second squared ms². These readings include the effects of gravity.
class AccelerometerSensor {
  Stream<AccelerometerEvent> getAccelerometerStream() {
    return accelerometerEventStream();
  }
}

// User accelerometer sensor from sensors_plus.
// Accelerometers measure the velocity of the device, returning values in meters per second squared ms². These readings do not include the effects of gravity.
class UserAccelerometerSensor {
  Stream<UserAccelerometerEvent> getUserAccelerometerStream() {
    return userAccelerometerEventStream();
  }
}

// Gyroscope sensor from sensors_plus.
// Discrete reading from a gyroscope. Gyroscopes measure the rate or rotation of the device in 3D space, returning radiants per second rad/s.
class GyroscopeSensor {
  Stream<GyroscopeEvent> getGyroscopeStream() {
    return gyroscopeEventStream();
  }
}

// Magnetometer sensor from sensors_plus.
// Magnetometers measure the ambient magnetic field surrounding the sensor, returning values in microteslas μT for each three-dimensional axis.
class MagnetometerSensor {
  Stream<MagnetometerEvent> getMagnetometerStream() {
    return magnetometerEventStream();
  }
}

// Barometer sensor from sensors_plus.
// Barometers measure the atmospheric pressure surrounding the sensor, returning values in hectopascals hPa.
class BarometerSensor {
  Stream<BarometerEvent> getBarometerStream() {
    return barometerEventStream();
  }
}
