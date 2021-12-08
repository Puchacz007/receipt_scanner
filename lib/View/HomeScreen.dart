import 'package:document_scanner/document_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_scanner/ViewModel/HomeScreenViewModel.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<PermissionStatus>? cameraPermissionFuture;
  @override
  void initState() {
    cameraPermissionFuture = Permission.camera.request();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        key: const Key('newReceipt'),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        onPressed: () {
          Provider.of<HomeScreenViewModel>(context, listen: false).addNewReceipt();
        },
      ),
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body:

      FutureBuilder<PermissionStatus>(
        future: cameraPermissionFuture,
        builder: (BuildContext context,
            AsyncSnapshot<PermissionStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isGranted)
              return
                Container(
                  child: DocumentScanner(
                    onDocumentScanned: (ScannedImage scannedImage) {
                      print("document : " + scannedImage.croppedImage!);
                      Provider.of<HomeScreenViewModel>(context, listen: false).scanReceipt(scannedImage.getScannedDocumentAsFile());
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
