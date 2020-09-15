import 'package:Comif_Server_App/database/transaction_queries.dart';
import 'package:Comif_Server_App/models/transaction.dart';
import 'package:Comif_Server_App/screens/admin/invoice_builder.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/app_bar_text.dart';
import 'package:Comif_Server_App/ui/texts/button_text.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
import 'package:Comif_Server_App/ui/widgets/counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';


class InvoiceConfirmationScreen extends StatelessWidget {
  final Transaction basket;

  InvoiceConfirmationScreen({Key key, this.basket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      appBar: AppBar(
        title: AppBarText('Récapitulatif'),
        backgroundColor: mainColor,
        actions: <Widget>[
          FlatButton(
            minWidth: 50,
            color: mainColor2,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InvoiceBuilderScreen(transaction: basket)));
            },
            child: Icon(Icons.arrow_back_ios_outlined, color: background,),
            ),
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
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                          child: Text(
                            'Produit',
                            style: TextStyle(
                              fontFamily: 'Pompiere',
                              fontWeight: FontWeight.bold,
                              fontSize: 35

                            ),
                            textAlign: TextAlign.center,
                          ),
                    flex: 60,
                  ),
                  Expanded(
                    child: Text('Qté',style: TextStyle(
                        fontFamily: 'Pompiere',
                        fontWeight: FontWeight.bold,
                        fontSize: 35
                    ),
                      textAlign: TextAlign.center,
                    ),
                    flex: 15,
                  ),
                  Expanded(
                    child: Text('Total',style: TextStyle(
                        fontFamily: 'Pompiere',
                        fontWeight: FontWeight.bold,
                        fontSize: 35
                    ),
                      textAlign: TextAlign.center,
                    ),
                    flex: 25,
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
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? font1 : font2,
                      border: Border.all(
                        width: 3,
                        color: font4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                              child: MainText(text: basket.products[index].productName,size: 30,alignment: TextAlign.center,color: index % 2 == 0 ? drawing : mainColor,weight: FontWeight.w600,),
                          flex: 60,
                            ),
                        Expanded(
                              child: MainText(text: basket
                                  .products[index].quantity
                                  .toString(),size: 30,alignment: TextAlign.center,color: index % 2 == 0 ? drawing : mainColor,weight: FontWeight.w600,),
                          flex: 15,
                            ),
                        Expanded(
                              child: MainText(text: displayPrice(
                                  basket.products[index].quantity *
                                      basket.products[index].price),size: 30,alignment: TextAlign.center,color: index % 2 == 0 ? drawing : mainColor,weight: FontWeight.w600,),
                          flex: 25,
                            ),
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
                    child: Text("Total",style: TextStyle(
                        fontFamily: 'Pompiere',
                        fontWeight: FontWeight.bold,
                        fontSize: 45
                    ),),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(""),
                  )),
                  Expanded(
                      child: Center(
                    child: Text(displayPrice(basket.total),style: TextStyle(
                        fontFamily: 'Pompiere',
                        fontWeight: FontWeight.bold,
                        fontSize: 45
                    ),),
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
                      child: ButtonText(text: "Valider le panier"),
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
