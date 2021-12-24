

import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:receipt_scanner/Model/DBprovider.dart';
import 'package:receipt_scanner/Model/item.dart';
import 'package:receipt_scanner/Model/receipt.dart';

import 'package:tesseract_ocr/tesseract_ocr.dart';
class ReceiptView extends StatefulWidget {
  const ReceiptView({Key key,@required this.receipt}) : super(key: key);

  final Receipt receipt;
  @override
  _ReceiptViewState createState() => _ReceiptViewState();
}

class _ReceiptViewState extends State<ReceiptView> {
  String receiptText ="";
  List<ItemWidget> itemWidgetList = [];
  @override
  initState() {
    super.initState();
    for (Item item in widget.receipt.items)
      {
        itemWidgetList.add(ItemWidget(item));
      }
    getImageText();
  }

  getImageText()
  async {
    final appDir = await  getTemporaryDirectory();
    File file = File('${appDir.path}/sth.jpg');
    await file.writeAsBytes(widget.receipt.scannedDocument);
    receiptText = await TesseractOcr.extractText(file.path);
    print (receiptText);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt view"),
        actions: [

          IconButton(
              onPressed: () async {
                await DBProvider.db.deleteReceipt(widget.receipt.id);
                setState(() {
                  Navigator.pop(context);

                });

              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body:

          SingleChildScrollView
            (
            child:

    IntrinsicHeight(
      child:
            Column(children: [
              Flexible(child:
              Text(widget.receipt.creationDate.toString()),
              ),
              Flexible(child:
              Text(widget.receipt.shopName),
              ),
              Flexible(child:
              Text(widget.receipt.totalPrice.toString()),
              ),

              Image.memory(widget.receipt.scannedDocument),
              /*Flexible(child:

              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 5),
                itemCount: itemWidgetList.length,
                itemBuilder: (_, index) =>
                itemWidgetList[index],
              ),

              ),*/
            ],
            ),
            ),


          )



    );
  }
}

class ItemWidget extends StatelessWidget
{

  final Item item;
  ItemWidget(this.item);
  @override
  Widget build(BuildContext context) {
   return
     IntrinsicHeight(
       child:
           Flexible(child:
     Row(

      children: [
        Text(item.name),
        Text(item.quantity.toString()),
        Text(item.price),


      ],
     ),
           ),
    );
  }
}