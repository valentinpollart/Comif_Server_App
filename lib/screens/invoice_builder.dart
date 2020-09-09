import 'dart:developer';

import 'package:Comif_Server_App/database/product_queries.dart';
import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/transaction.dart';
import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:Comif_Server_App/screens/invoice_confirmation.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
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
    if (_clientSelected || basket != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Qu\'est-ce-qu\'on sert ?'),
            backgroundColor: main,
            actions: <Widget>[
              InkWell(
                onTap: () {
                  basket.userId = null;
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
          title: Text('Qui est servi ?'),
          backgroundColor: main,
        ),
        body: buildClientList(context),
        drawer: MainDrawer(),
      );
    }
  }

  Widget buildClientList(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SearchBar<User>(
          minimumChars: 1,
          onSearch: searchUser,
          mainAxisSpacing: 10,
          searchBarPadding: EdgeInsets.symmetric(horizontal: 15),
          listPadding: EdgeInsets.symmetric(horizontal: 20),
          onItemFound: (User user, int index) {
            return Container(
              decoration: BoxDecoration(
                color: index % 2 == 0 ? font1 : font2,
                border: Border.all(
                  width: 3,
                  color: font4,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListTile(
                title: Text(
                  user.firstName + ' ' + user.lastName,
                  style: TextStyle(color: drawing),
                ),
                isThreeLine: false,
                subtitle: Text(
                  displayPrice(user.balance),
                  style: TextStyle(color: drawing),
                ),
                onTap: () {
                  basket.userId = user.id;
                  setState(() {
                    _clientSelected = !_clientSelected;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildProductList(BuildContext context) {
    basket = ModalRoute.of(context).settings.arguments ?? basket;
    return Scaffold(
      backgroundColor: background,
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
                              title: Text(
                                product.name,
                                style: TextStyle(color: drawing),
                              ),
                              isThreeLine: false,
                              subtitle: Text(
                                displayPrice(product.salePrice),
                                style: TextStyle(color: drawing),
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Counter(
                              color: background,
                              iconColor: font4,
                              tag: "product$index",
                              textStyle: TextStyle(color: drawing, fontSize: 18),
                              initialValue:
                                  basket.getProductQuantity(product.id) ?? 0,
                              minValue: 0,
                              step: 1,
                              onChanged: (value) {
                                setState(() {
                                  basket.total += product.salePrice;
                                  basket.setProduct(
                                      product.id,
                                      ProductInBasket(
                                          productId: product.id,
                                          quantity: value));
                                });
                              },
                              decimalPlaces: 0,
                              maxValue: 999,
                            ))
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
