// import 'package:dio/dio.dart';
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
  bool loading = false;
  PdfViewerController? _pdfViewerController;
  // Dio dio = Dio();
  // double progress = 0;
  // void downloading() async {
  //   String filename = widget.paperyear.toString();
  //   String path = await _getFilePath(filename);
  //   print(path);
  //   await dio.download(widget.pdfurl.toString(), path,
  //       onReceiveProgress: (count, total) {
  //     setState(() {
  //       progress = count / total;
  //     });
  //     print(progress);
  //   }, deleteOnError: true);
  // }

  // Future<String> _getFilePath(String filename) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   return "${dir?.path}/$filename paper";
  // }

  // @override
  // void initState() {
  //   downloading();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //  String downloadProgress = (progress * 100).toInt.toString();
    //print(widget.paperyear);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paperyear.toString()),
        actions: [
          //  Text(downloadProgress),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: () {
                //  downloading();
              },
              child: const Icon(
                Icons.download,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdfurl.toString(),
        controller: _pdfViewerController,
        enableDocumentLinkAnnotation: false,
      ),
    );
  }
}
