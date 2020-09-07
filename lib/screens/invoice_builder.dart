import 'dart:developer';

import 'package:Comif_Server_App/database/product_queries.dart';
import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/basket.dart';
import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:Comif_Server_App/screens/invoice_confirmation.dart';
import 'package:Comif_Server_App/ui/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter_counter/flutter_counter.dart';

class InvoiceBuilderScreen extends StatefulWidget {
  final Basket basket;

  InvoiceBuilderScreen({this.basket});

  @override
  _InvoiceBuilderScreenState createState() =>
      _InvoiceBuilderScreenState(basket: basket);
}

class _InvoiceBuilderScreenState extends State<InvoiceBuilderScreen> {
  bool _clientSelected = false;
  Basket basket;

  _InvoiceBuilderScreenState({this.basket});

  @override
  Widget build(BuildContext context) {
    if (_clientSelected) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Qu\'est-ce-qu\'on sert ?'),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  basket.client = null;
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
      basket = basket ?? new Basket(client: null, products: new Map<Product, int>());
      return Scaffold(
        appBar: AppBar(
          title: Text('Qui est servi ?'),
        ),
        body: buildClientList(context),
        drawer: MainDrawer(),
      );
    }
  }

  Widget buildClientList(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SearchBar<User>(
          minimumChars: 1,
          onSearch: searchUser,
          onItemFound: (User user, int index) {
            return Container(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(user.firstName + ' ' + user.lastName),
                isThreeLine: true,
                subtitle: Text(user.balance.toString()),
                onTap: () {
                  basket.client = user;
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
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SearchBar<Product>(
              minimumChars: 1,
              onSearch: searchProduct,
              onItemFound: (Product product, int index) {
                return Container(
                    color: index % 2 == 0 ? Colors.lightBlue : Colors.red,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: ListTile(
                              title: Text(product.name),
                              isThreeLine: false,
                              subtitle: Text(product.displayPrice()),
                            )),
                        Expanded(
                            flex: 1,
                            child: Counter(
                              initialValue: basket.products[product] ?? 0,
                              minValue: 0,
                              step: 1,
                              onChanged: (value) {
                                setState(() {
                                  basket.products[product] = value;
                                });
                              },
                              decimalPlaces: 0,
                              maxValue: 999,
                            ))
                      ],
                    )
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          InvoiceConfirmationScreen(basket: basket)
                  )
              );
            },
            child: Text('Aller au récapitulatif'),
          ),
        ],
      )),
    );
  }
}
