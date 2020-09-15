import 'dart:developer';

import 'package:Comif_Server_App/database/product_queries.dart';
import 'package:Comif_Server_App/models/transaction.dart';
import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/screens/admin/invoice_confirmation.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/app_bar_text.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
import 'package:Comif_Server_App/ui/widgets/client_list.dart';
import 'package:Comif_Server_App/ui/widgets/counter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';

class InvoiceBuilderScreen extends StatefulWidget {
  final Transaction transaction;

  InvoiceBuilderScreen({this.transaction});

  @override
  _InvoiceBuilderScreenState createState() =>
      _InvoiceBuilderScreenState(basket: transaction);
}

class _InvoiceBuilderScreenState extends State<InvoiceBuilderScreen> {
  Transaction basket;
  bool _clientSelected = false;

  _InvoiceBuilderScreenState({this.basket});

  @override
  Widget build(BuildContext context) {
    if((basket?.products?.isNotEmpty ?? false) && !_clientSelected){
      _clientSelected = !_clientSelected;
    }
    if (_clientSelected) {
      return Scaffold(
          appBar: AppBar(
            title: AppBarText('Qu\'est-ce qu\'on sert ?'),
            backgroundColor: mainColor,
            actions: <Widget>[
              FlatButton(
                minWidth: 50,
                color: mainColor2,
                onPressed: () {
                  basket.userId = null;
                  basket.products = new List<ProductInBasket>();
                  setState(() {
                    _clientSelected = !_clientSelected;
                  });
                },
                child: Icon(Icons.arrow_back_ios_outlined),
              )
            ],
          ),
          body: buildProductList(context),
          drawer: MainDrawer());
    } else {
      basket = basket ??
          new Transaction(userId: null, products: new List<ProductInBasket>());
      return Scaffold(
        appBar: AppBar(
          title: AppBarText('Qui est servi ?'),
          backgroundColor: mainColor,
        ),
        body: ClientList(
            clientSelected: (id) => {
                  setState(() {
                    _clientSelected = !_clientSelected;
                    basket.userId = id;
                  })
                }),
        drawer: MainDrawer(),
      );
    }
  }

  Widget buildProductList(BuildContext context) {
    basket = ModalRoute.of(context).settings.arguments ?? basket;
    return Scaffold(
      backgroundColor: background2,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SearchBar<Product>(
              minimumChars: 1,
              onSearch: searchProduct,
              mainAxisSpacing: 10,
              searchBarPadding: EdgeInsets.symmetric(horizontal: 15),
              listPadding: EdgeInsets.symmetric(horizontal: 20),
              onItemFound: (Product product, int index) {
                return Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0 ? font1 : font2,
                      border: Border.all(
                        width: 3,
                        color: font4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 8,
                            child: ListTile(
                              title: MainText(
                                text: product.name,
                                size: 25,
                                color: index % 2 == 0 ? drawing : mainColor,
                                weight: FontWeight.w900,

                              ),
                              isThreeLine: false,
                            )),
                        Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Counter(
                                  color: background,
                                  iconColor: font4,
                                  tag: "product$index",
                                  textStyle:
                                  TextStyle(color: index % 2 == 0 ? drawing : mainColor, fontSize: 18),
                                  initialValue:
                                  basket.getProductQuantity(product.id) ?? 0,
                                  minValue: 0,
                                  step: 1,
                                  onChanged: (value) {
                                    setState(() {
                                      basket.setProduct(
                                          product.id,
                                          ProductInBasket(
                                              productId: product.id,
                                              quantity: value,
                                              productName: product.name,
                                              price: product.salePrice),
                                          product.salePrice);
                                    });
                                  },
                                  decimalPlaces: 0,
                                  maxValue: 999,
                                ),
                                Container(
                                  child: MainText(
                                    text: displayPrice(product.salePrice),
                                    size: 18,
                                    color: index % 2 == 0 ? drawing : mainColor,
                                    weight: FontWeight.w900,
                                  ),
                                )
                              ],
                            )
                        )
                      ],
                    ));
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              _clientSelected = !_clientSelected;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InvoiceConfirmationScreen(basket: basket)));
            },
            child: Text('Aller au récapitulatif'),
          ),
        ],
      )),
    );
  }
}
