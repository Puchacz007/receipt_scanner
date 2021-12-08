
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:receipt_scanner/Model/DBprovider.dart';

import 'package:receipt_scanner/Model/receipt.dart';

class HomeScreenViewModel with ChangeNotifier {


  List<Receipt> _receiptList = <Receipt>[];



  List<Receipt>? get receipt {
    return _receiptList;
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> fetchReceiptData(String value) async {
    try {

      this._receiptList = DBProvider.db.getAllReceipts() as List<Receipt>;

    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
  addNewReceipt()
  {

  }
  scanReceipt(File scannedDocument)
  async {

    Receipt receipt = Receipt(id: (DBProvider.db.getMaxReceiptID() as int) + 1, creationDate: DateTime.now(),scannedDocument: scannedDocument);
    await DBProvider.db.addReceipt(receipt);
  }
  void setReceiptMedia(Receipt receipt) {
    _receiptList = _receiptList;
    notifyListeners();
  }
}
