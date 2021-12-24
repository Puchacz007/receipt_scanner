
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipt_scanner/Model/DBprovider.dart';
import 'package:receipt_scanner/Model/receipt.dart';
import 'package:receipt_scanner/View/receiptView.dart';
import 'package:receipt_scanner/View/scannerView.dart';
import 'package:permission_handler/permission_handler.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<PermissionStatus> cameraPermissionFuture;

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
        onPressed: () async {
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const ScannerView(),
            ),
          ).then((value) => setState);
        },
      ),
      appBar: AppBar(
        title: Text("HomeScreen"),
      ),
      body:

    FutureBuilder(
    future: DBProvider.db.getAllReceipts(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      List<Widget> children = [];
      if (snapshot.hasData) {

        final List<Receipt> receiptList = snapshot.data;
        for (Receipt receipt in receiptList)
          {
            children.add(
                  Card(
                      child: ListTile(
                        title: Center(
                          child: Text('${receipt.creationDate.toString()}'),
                        ),
                        onLongPress: ()
                        {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ReceiptView(receipt: receipt,),
                            ),
                          ).then((value) => setState);
                        },
                  )

                  )
              );
          }

      }
      else {
        children = const <Widget>[
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),

          )
        ];
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      );
    }

      ),

    );
  }
}
