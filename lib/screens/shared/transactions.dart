import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/database/transaction_queries.dart';
import 'package:Comif_Server_App/models/transaction.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/dates.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Mes transactions'),
      ),
      body: Container(
          color: background2,
          child: FutureBuilder(
            future: listUserTransactions(SharedPrefs.userId),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                List<Transaction> transactions = snapshot.data;
                return ListView.builder(
                  itemBuilder: (BuildContext context, int transactionIndex) {
                    return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: MainText(
                                text: displayDate(
                                    transactions[transactionIndex].createdAt),
                                color: font4,
                                size: 18,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: mainColor,
                                border: Border.all(
                                  width: 3,
                                  color: font4,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  transactions[transactionIndex].products.isNotEmpty
                                      ? Column(
                                          children: transactions[transactionIndex]
                                              .products
                                              .map((product) => MainText(
                                                    text: product.productName +
                                                        " x" +
                                                        product.pivot.toString(),
                                                    size: 30,
                                                  ))
                                              .toList(),
                                        )
                                      : MainText(
                                          text: "Recharge",
                                          size: 30,
                                        ),
                                  Container(
                                    child: MainText(
                                      text: displayPrice(
                                          transactions[transactionIndex].total),
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                    ));
                  },
                );
              } else {
                return Container(
                  color: background,
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                  ),
                );
              }
            },
          )),
      drawer: MainDrawer(),
    );
  }
}
