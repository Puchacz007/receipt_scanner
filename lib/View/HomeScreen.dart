import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_scanner/ViewModel/HomeScreenViewModel.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
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
      body: Container(

        ),

    );
  }
}
