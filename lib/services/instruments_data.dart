class InstrumentsData {
  double _heading = 0.0;
  double _roll = 0.0;
  double _pitch = 0.0;
  double _altitude = 0.0;
  double _verticalSpeed = 0.0;
  double _throttle1 = 0.0;
  double _throttle2 = 0.0;
  double _throttle3 = 0.0;
  double _throttle4 = 0.0;

  double getHeading() {
    return _heading;
  }

  double getRoll() {
    return _roll;
  }

  double getPitch() {
    return _pitch;
  }

  double getAltitude() {
    return _altitude;
  }

  double getVerticalSpeed() {
    return _verticalSpeed;
  }

  double getThrottle1() {
    return _throttle1;
  }

  double getThrottle2() {
    return _throttle2;
  }

  double getThrottle3() {
    return _throttle3;
  }

  double getThrottle4() {
    return _throttle4;
  }

  void setHeading(double value) {
    _heading = value;
  }

  void setRoll(double value) {
    _roll = value;
  }

  void setPitch(double value) {
    _pitch = value;
  }

  void setAltitude(double value) {
    _altitude = value;
  }

  void setVerticalSpeed(double value) {
    _verticalSpeed = value;
  }

  void setThrottle1(double throttle) {
    _throttle1 = throttle;
  }

  void setThrottle2(double throttle) {
    _throttle2 = throttle;
  }

  void setThrottle3(double throttle) {
    _throttle3 = throttle;
  }

  void setThrottle4(double throttle) {
    _throttle4 = throttle;
  }
}
