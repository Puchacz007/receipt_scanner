class Item
{
  var price;
  int quantity;
  String name;
  int receiptID;
  Item({this.price,this.quantity,this.name,this.receiptID});

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    name: json['NAME'] as String,
    receiptID: json['RECEIPT_ID'] as int,
    price: json['PRICE'],
    quantity: json['QUANTITY'] as int
  );

  Map<String, Object> toMap() => <String, Object>{
    'NAME': name,
    'RECEIPT_ID': receiptID,
    'PRICE': price,
    'QUANTITY': quantity
  };
}