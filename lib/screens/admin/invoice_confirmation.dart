import 'package:Comif_Server_App/database/transaction_queries.dart';
import 'package:Comif_Server_App/models/transaction.dart';
import 'package:Comif_Server_App/screens/admin/invoice_builder.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';


class InvoiceConfirmationScreen extends StatelessWidget {
  final Transaction basket;

  InvoiceConfirmationScreen({Key key, this.basket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text('Récapitulatif'),
        backgroundColor: main,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InvoiceBuilderScreen(transaction: basket)));
            },
            child: Icon(Icons.arrow_back_ios_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 10,
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(child: Center(child: Text('Produit'))),
                  Expanded(
                      child: Center(
                    child: Text('Quantité'),
                  )),
                  Expanded(
                      child: Center(
                    child: Text('Total'),
                  ))
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(

                padding: const EdgeInsets.all(8),
                itemCount: basket.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? font1 : font2,
                      border: Border.all(
                        width: 3,
                        color: font4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                              child: Text(basket.products[index].productName,style: TextStyle(color: drawing),),
                            )),
                        Expanded(
                            child: Center(
                              child: Text(basket
                                  .products[index].quantity
                                  .toString(),style: TextStyle(color: drawing),),
                            )),
                        Expanded(
                            child: Center(
                              child: Text(displayPrice(
                                  basket.products[index].quantity *
                                      basket.products[index].price),style: TextStyle(color: drawing),),
                            )),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                      height: 10,
                    ),
              ),
            ),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: Center(
                    child: Text("Total"),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(""),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(displayPrice(basket.total)),
                  )),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                      child: Center(
                    child: RaisedButton(
                      onPressed: () => _validate(context),
                      child: Text("Valider le panier"),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
      drawer: MainDrawer(),
    );
  }

  _validate(BuildContext context) {
    postTransaction(basket);
    basket.empty();
    Navigator.of(context).pushNamedAndRemoveUntil('/invoice', (route) => false);
  }
}
