class InstrumentsData {
  double _compass = 0.0;
  double _throttle = 0.0;

  double GetCompassValue() {
    return _compass;
  }

  double GetThrottleValue() {
    return _throttle;
  }

  void SetCompassValue(double compass) {
    _compass = compass;
  }

  void SetThrottleValue(double throttle) {
    _throttle = throttle;
  }
}
