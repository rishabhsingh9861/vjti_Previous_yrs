// import 'package:dio/dio.dart';
// import 'dart:io';

// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path/path.dart' as Path;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewFyMst extends StatefulWidget {
  const ViewFyMst({super.key, this.pdfurl, this.paperyear});
  final String? pdfurl;
  final String? paperyear;

  @override
  State<ViewFyMst> createState() => _ViewFyMstState();
}

class _ViewFyMstState extends State<ViewFyMst> {
  // bool loading = false;
  // bool downloading = false;
  // bool fileExists = false;
  // double progress = 0;
  // bool isPermission = false;
  PdfViewerController? _pdfViewerController;
  // var checkAllPermission = CheckPermission();
  // var getPathFile = DirectoryPath();
  // String? filePath;
  // String fileName = '';

  // checkPermission() async {
  //   var permission = await checkAllPermission.isstoragePermission();
  //   if (permission) {
  //     setState(() {
  //       isPermission = true;
  //     });
  //   }
  // }

  // checkFileExists() async {
  //   var storePath = await getPathFile.getPath();
  //   filePath = '$filePath/$fileName';
  //   bool fileExistsCheck = await File(filePath!).exists();
  //   setState(() {
  //     fileExists = fileExistsCheck;
  //   });
  // }

  // startDownloading() async {
  //   try {
  //     await Dio().download(
  //       widget.pdfurl.toString(),
  //       filePath.toString(),
  //       onReceiveProgress: (count, total) {
  //         setState(() {
  //           progress = (count / total);
  //           print(progress);
  //         });
  //       },
  //     );
  //     // setState(() {
  //     //   downloading = false;
  //     //   fileExists = true;
  //     // });
  //   } catch (e) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             content: Text(e.toString()),
  //           );
  //         });
  //   }
  // }

  // @override
  // void initState() {
  //   checkPermission();
  //   fileName = Path.basename(widget.paperyear.toString());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paperyear.toString()),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 15),
        //     child: InkWell(
        //       onTap: () {
        //         // if (isPermission = true) {
        //         //   startDownloading();
        //         // } else {
        //         //   showDialog(
        //         //       context: context,
        //         //       builder: (context) {
        //         //         return const AlertDialog(
        //         //           content: Text("Permission Issue"),
        //         //         );
        //         //       });
        //         // }
        //       },
        //       child: const Icon(
        //         Icons.download,
        //         size: 35,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SfPdfViewer.network(
        widget.pdfurl.toString(),
        controller: _pdfViewerController,
        enableDocumentLinkAnnotation: false,
      ),
    );
  }
}

// Check permission

// class CheckPermission {
//   Future<bool> isstoragePermission() async {
//     var isStorage = await Permission.storage.status;
//     var isAccesLc = await Permission.accessMediaLocation.status;
//     var isManagExt = await Permission.manageExternalStorage.status;
//     if (!isStorage.isGranted || !isAccesLc.isGranted || !isManagExt.isGranted) {
//       await Permission.storage.request();
//       await Permission.accessMediaLocation.request();
//       await Permission.manageExternalStorage.request();
//       if (!isStorage.isGranted ||
//           !isAccesLc.isGranted ||
//           !isManagExt.isGranted) {
//         return false;
//       } else {
//         return true;
//       }
//     } else {
//       return true;
//     }
//   }
// }

// // Directory path

// class DirectoryPath {
//   getPath() async {
//     final path = Directory(
//         "/storage/emulated/0/Android/media/com.example.vjti_previous/files");
//     if (await path.exists()) {
//       return path.path;
//     } else {
//       path.create(recursive: false);
//       return path.path;
//     }
//   }
// }
