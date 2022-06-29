import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HistoryReport extends StatefulWidget {
  final String notifId;

  const HistoryReport({required this.notifId});
  @override
  _HistoryReportState createState() => _HistoryReportState();
}

class _HistoryReportState extends State<HistoryReport> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl:
            "https://app.ragdalion.com/ecm_client/webviewreportpdfecm?id=${widget.notifId}",
      ),
    );
  }
}
