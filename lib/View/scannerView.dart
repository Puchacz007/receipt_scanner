import 'package:document_scanner/document_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_scanner/ViewModel/HomeScreenViewModel.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({Key key}) : super(key: key);


  @override
  _ScannerViewState createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> {

  Future<PermissionStatus> cameraPermissionFuture;
  @override
  void initState() {
    cameraPermissionFuture = Permission.camera.request();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("scannerView"),
      ),
      body:

      FutureBuilder<PermissionStatus>(
        future: cameraPermissionFuture,
        builder: (BuildContext context,
            AsyncSnapshot<PermissionStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data.isGranted)
              return
                Container(
                  child: DocumentScanner(
                    onDocumentScanned: (ScannedImage scannedImage) async {
                      print("document : " + scannedImage.croppedImage);



                      await Provider.of<HomeScreenViewModel>(context, listen: false).scanReceipt(scannedImage.getScannedDocumentAsFile());
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                );

            else
              return Center(
                child: Text("camera permission denied"),
              );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },

      ),
    );
  }
}
