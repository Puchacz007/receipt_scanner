
import 'package:receipt_scanner/Model/item.dart';

class Receipt
{
List<Item> items = <Item>[];
DateTime creationDate;
var priceSum;
String shopName;
Receipt(this.shopName,this.creationDate);



}