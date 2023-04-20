import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewFyMst extends StatefulWidget {
  ViewFyMst({this.pdfurl});
  final String? pdfurl;

  @override
  State<ViewFyMst> createState() => _ViewFyMstState();
}

class _ViewFyMstState extends State<ViewFyMst> {
  PdfViewerController? _pdfViewerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      appBar: AppBar(
        title: Text('pdf'),
      ),
      body: SfPdfViewer.network(
        
        widget.pdfurl.toString(),
        controller: _pdfViewerController,
      ),
    );
  }
}
