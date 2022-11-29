import 'package:boilerplate/widgets/base_app_bar.dart';
import 'package:flutter/material.dart';

class MyWalletScreen extends StatefulWidget {
  @override
  _MyWalletScreenState createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(titleKey: "my_wallet_title"),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Métodos de pago',
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 50, height: 50),
          _buildTable("/pay_request"),

        ],
      ),
    );
  }

  Widget _buildTable(route) {
    return Container(
      margin: EdgeInsets.all(0),
      child: Table(
        children: [
          TableRow(
              decoration: new BoxDecoration(color: Colors.grey),
              children: [
                TextButton(
                  onPressed: () => {
                    Navigator.of(context).pushNamed(route)
                  },
                  child:
                Row(
                    children:[
                  Icon(
                      Icons.add_card, color: Colors.black),
                  SizedBox(width: 5),
                  Text('******5968',
                    style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
                      ]),
                ),
          ]),
          TableRow(

              decoration: new BoxDecoration(color: Colors.blueGrey),
              children: [
                TextButton(
                  onPressed: () => {
                    Navigator.of(context).pushNamed(route)
                  },
                 child:
                    Row(children:[
                    Icon(Icons.add_card, color: Colors.black),
                    SizedBox(width: 5),
                    Text('******7980',
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        ))]),
                ),
          ]),
          TableRow(

              decoration: new BoxDecoration(color: Colors.grey),
              children: [
                TextButton(
                   onPressed: () => {
                         Navigator.of(context).pushNamed(route)
                  },child:
                  Row(

                      children:[
                  Icon(Icons.money, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Efectivo',
                  style: TextStyle(
                  color: Colors.black, fontSize: 20,)
                  )]),
                ),
          ]),
          TableRow(
              decoration: new BoxDecoration(color: Colors.blueGrey),
              children: [
                TextButton(
                  onPressed: () => {
                  Navigator.of(context).pushNamed(route)
                },child:
                Row(children:[
                  Icon(Icons.add, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Agregar método de pago', style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ))]),
                ),
          ]),
        ],
      ),
    );
  }
}
