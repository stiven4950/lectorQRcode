import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String typeSelected = 'http';

  Future<ScanModel> nuevoScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.newScan(newScan);
    newScan.id = id;

    if (this.typeSelected == newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getAll();
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScansPorTipo(String type) async {
    final scans = await DBProvider.db.getAllIf(type);
    this.scans = [...scans];
    this.typeSelected = type;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAll();
    this.scans = [];
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
  }

  // Luego de terminar el Scans Provider se debe implementar
  // en la lista de multiprovider ubicado en el main de la app.
}
