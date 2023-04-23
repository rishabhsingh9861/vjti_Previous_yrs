import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewFyMst extends StatefulWidget {
  const ViewFyMst({super.key, this.pdfurl, this.paperyear});
  final String? pdfurl;
  final String? paperyear;

  @override
  State<ViewFyMst> createState() => _ViewFyMstState();
}

class _ViewFyMstState extends State<ViewFyMst> {
  PdfViewerController? _pdfViewerController;

  @override
  Widget build(BuildContext context) {
    // print(widget.paperyear);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paperyear.toString()),
        actions: [],
      ),
      body: SfPdfViewer.network(
        widget.pdfurl.toString(),
        controller: _pdfViewerController,
        enableDocumentLinkAnnotation: false,
      ),
    );
  }
}
