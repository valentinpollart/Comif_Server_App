import 'package:Comif_Server_App/database/product_queries.dart';
import 'package:Comif_Server_App/models/basket.dart';
import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/screens/invoice_builder.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvoiceConfirmationScreen extends StatelessWidget {
  final Basket basket;

  InvoiceConfirmationScreen({Key key, this.basket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> productList = new List<Product>();
    int total = 0;
    Future.forEach(basket.products.keys,(id) async {
      debugPrint(id.toString());
      var product = await getProduct(id);
      debugPrint(id.toString());
      debugPrint(product.toString());
      total += product.salePrice * basket.products[id];
      productList.add(product);
    });
    debugPrint(productList.toString());
    return Hero(
        tag: this.hashCode,
        child: Scaffold(
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
                      Expanded(
                          child: Center(
                              child: Text('Produit')
                          )
                      ),
                      Expanded(
                          child: Center(
                            child: Text('Quantité'),
                          )
                      ),
                      Expanded(
                          child: Center(
                            child: Text('Total'),
                          )
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: basket.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: Center(
                                    child: Text(productList[index].name),
                                )
                            ),
                            Expanded(
                                child: Center(
                                  child: Text(basket.products[index]
                                      .toString()),
                                )
                            ),
                            Expanded(
                                child: Center(
                                  child: Text(displayPrice(basket.products[index]*productList[index].salePrice)),
                                )
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                            child: Text("Total"),
                          )
                      ),
                      Expanded(
                          child: Center(
                            child: Text(""),
                          )
                      ),
                      Expanded(
                          child: Center(
                              child: Text(displayPrice(total)),
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          drawer: MainDrawer(),
        )
    );
  }
}
