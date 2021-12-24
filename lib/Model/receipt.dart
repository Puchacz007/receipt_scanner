import 'dart:typed_data';

import 'package:receipt_scanner/Model/item.dart';

class Receipt
{
  int id;
  final Uint8List scannedDocument;
List<Item> items = <Item>[];
DateTime creationDate;
double totalPrice;
String shopName;
Receipt({this.id,this.shopName = '',this.creationDate,this.scannedDocument,this.totalPrice = -1});



  factory Receipt.fromMap(Map<String, dynamic> json) => Receipt(
      id: json['ID'] as int,
      scannedDocument: json['SCANNED_DOCUMENT'],
      creationDate: json['CREATION_DATE'] != null ?
  DateTime.fromMillisecondsSinceEpoch(json['CREATION_DATE'] as int): null,
      shopName: json['SHOP_NAME'] as String,
      totalPrice: json['TOTAL_PRICE'] as double,
     );
  Map<String, Object> toMap() => <String, Object>{
    'ID': id,
    'SCANNED_DOCUMENT': scannedDocument,
    'CREATION_DATE': creationDate.millisecondsSinceEpoch,
    'SHOP_NAME': shopName,
    'TOTAL_PRICE': totalPrice
  };


}