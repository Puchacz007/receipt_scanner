import 'package:receipt_scanner/Model/receipt.dart';

class Database
{
  List<Receipt> receiptList = <Receipt>[];

  Database();

  addReceipt(Receipt receipt)
  {
    receiptList.add(receipt);
  }
  modifyReceipt()
  {

  }
  removeReceipt()
  {

  }
}