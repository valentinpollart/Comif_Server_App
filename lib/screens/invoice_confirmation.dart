import 'package:Comif_Server_App/models/basket.dart';
import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/screens/invoice_builder.dart';
import 'package:Comif_Server_App/ui/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvoiceConfirmationScreen extends StatelessWidget {
  final Basket basket;

  InvoiceConfirmationScreen({Key key, @required this.basket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> productList = basket.products.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Récapitulatif'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InvoiceBuilderScreen(basket: basket)));
            },
            child: Icon(Icons.arrow_back_ios_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Expanded(child: Text('Produit')),
                  Expanded(child: Text('Prix unit.')),
                  Expanded(child: Text('Qté')),
                  Expanded(child: Text('Total'))
                ],
              ),
            ),
            // Expanded(
            //   child: ListView.separated(
            //     padding: const EdgeInsets.all(8),
            //     itemCount: basket.products.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Container(
            //         child: Row(
            //           children: [
            //             Expanded(child: Text(productList[index].name)),
            //             Expanded(
            //                 child: Text(productList[index].displayPrice())),
            //             Expanded(
            //                 child: Text(basket.products[productList[index]]
            //                     .toString())),
            //             Expanded(
            //                 child: Text(basket
            //                     .getProductTotal(productList[index])
            //                     .toString()))
            //           ],
            //         ),
            //       );
            //     },
            //     separatorBuilder: (BuildContext context, int index) =>
            //         const Divider(),
            //   ),
            // ),
            Container(
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text("Total")),
                  Expanded(child: Text(basket.getBasketTotal().toString()))
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
