
import 'dart:io';

import 'package:receipt_scanner/Model/item.dart';

class Receipt
{
  int id;
  File scannedDocument;
List<Item> items = <Item>[];
DateTime? creationDate;
var totalPrice;
String? shopName;
Receipt({required this.id,this.shopName,this.creationDate,required this.scannedDocument,this.totalPrice});



  factory Receipt.fromMap(Map<String, dynamic> json) => Receipt(
      id: json['ID'] as int,
      scannedDocument: json['SCANNED_DOCUMENT'],
      creationDate: json['CREATION_DATE'] != null ?
  DateTime.fromMillisecondsSinceEpoch(json['CREATION_DATE'] as int): null,
      shopName: json['SHOP_NAME'] as String,
      totalPrice: json['TOTAL_PRICE'] as int,
     );
  Map<String, Object> toMap() => <String, Object>{
    'ID': id,
    'SCANNED_DOCUMENT': scannedDocument,
    'CREATION_DATE': creationDate!.millisecondsSinceEpoch,
    'SHOP_NAME': shopName as String,
    'TOTAL_PRICE': totalPrice
  };


}