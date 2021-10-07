import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

import 'package:qr_reader/utils/utils.dart' as util;

class ScanTiles extends StatelessWidget {
  const ScanTiles({
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        onDismissed: (direction) {
          scanListProvider.borrarScanPorId(scans[i].id!);
        },
        key: UniqueKey(),
        background: Container(
          alignment: Alignment.centerLeft,
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        child: ListTile(
          leading: Icon(
            this.type == 'http' ? Icons.cloud_queue : Icons.map,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[i].value),
          subtitle: Text("ID: ${scans[i].id}"),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () => util.openScan(context, scans[i]),
        ),
      ),
    );
  }
}
