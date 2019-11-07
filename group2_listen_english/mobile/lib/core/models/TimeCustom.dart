class Time {
  int hour = 0;
  int minute = 0;
  int second = 0;
  int millisecond = 0;

  Time({this.hour, this.minute, this.second, this.millisecond});

  Time.fromString(String timeString) {
    this.hour = int.parse(timeString.substring(0, 2));
    this.minute = int.parse(timeString.substring(3, 5));
    this.second = int.parse(timeString.substring(6, 8));
    this.millisecond = int.parse(timeString.substring(9));
  }

  String toString() {
    return "$hour:$minute:$second.$millisecond";
  }
}
