class InitStart {
  static String table = "entries";

  int? id;
  String? date;
  String? duration;
  double? speed;
  double? distance;

  InitStart({this.id, this.date, this.duration, this.speed, this.distance});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'duration': duration,
      'speed': speed,
      'distance': distance
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static InitStart fromMap(Map<String, dynamic> map) {
    return InitStart(
        id: map['id'],
        date: map['date'],
        duration: map['duration'],
        speed: map['speed'],
        distance: map['distance']);
  }
}
