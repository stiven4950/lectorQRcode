import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
// Solo se muestra una clase de todas las inlcuídas en ese paquete

class ScanModel {
  ScanModel({
    this.id,
    this.type,
    required this.value,
  }) {
    if (this.value.contains('http')) {
      this.type = 'http';
    } else {
      this.type = 'geo';
    }
  }

  int? id;
  String? type;
  String value;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  LatLng getLatLng() {
    // Cuts string in 4 position index
    final lalo = this.value.substring(4).split(',');
    final lat = double.parse(lalo[0]);
    final lng = double.parse(lalo[1]);

    return LatLng(lat, lng);
  }
}
