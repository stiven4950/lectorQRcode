import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/pages/map_page.dart';
import 'package:url_launcher/url_launcher.dart';

void openScan(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    final url = scan.value;
    await canLaunch(scan.value)
        ? await launch(scan.value)
        : throw 'Could not launch $url';
  } else {
    Navigator.pushNamed(
      context,
      MapPage.route,
      arguments: scan,
    );
  }
}
