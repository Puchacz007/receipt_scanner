
import 'package:flutter/cupertino.dart';
import 'package:receipt_scanner/Model/database.dart';
import 'package:receipt_scanner/Model/receipt.dart';

class HomeScreenViewModel with ChangeNotifier {


  List<Receipt> _receiptList = <Receipt>[];
 Database database = Database();


  List<Receipt>? get receipt {
    return _receiptList;
  }

  /// Call the media service and gets the data of requested media data of
  /// an artist.
  Future<void> fetchReceiptData(String value) async {
    try {

      final List<Receipt> _receiptList = database.receiptList;
      this._receiptList = _receiptList.map((item) => Receipt(item.shopName,item.creationDate)).toList();

    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
  addNewReceipt()
  {
    Receipt receipt = Receipt("", DateTime.now());
        database.addReceipt(receipt);
  }
  void setReceiptMedia(Receipt receipt) {
    _receiptList = _receiptList;
    notifyListeners();
  }
}
