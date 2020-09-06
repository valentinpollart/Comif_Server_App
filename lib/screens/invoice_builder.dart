import 'dart:developer';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/database/product_queries.dart';
import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:Comif_Server_App/ui/main_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter_counter/flutter_counter.dart';

class InvoiceBuilderScreen extends StatefulWidget {
  @override
  _InvoiceBuilderScreenState createState() => _InvoiceBuilderScreenState();
}

class _InvoiceBuilderScreenState extends State<InvoiceBuilderScreen> {
  bool _clientSelected = false;
  User client;
  Map<Product, int> basket = new Map();

  @override
  Widget build(BuildContext context) {
    if (_clientSelected) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Qu\'est-ce-qu\'on sert ?'),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  client = null;
                  setState(() {
                    _clientSelected = !_clientSelected;
                  });
                },
                child: Icon(
                    Icons.arrow_back_ios_outlined
                ),
              )
            ],
          ),
          body: buildProductList(context),
          drawer: MainDrawer()
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Qui est servi ?'),

          ),
          body: buildClientList(context)
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
                  client = user;
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
                          color: Colors.lightBlue,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ListTile(
                                    title: Text(product.name),
                                    isThreeLine: true,
                                    subtitle: Text(product.salePrice.toString()),
                                  ),
                                  Counter(
                                    initialValue: basket[product] ?? 0,
                                    minValue: 0,
                                    step: 1,
                                    onChanged: (value) {
                                      setState(() {
                                        basket[product] = value;
                                      });
                                    },
                                    decimalPlaces: 0,
                                    maxValue: product.stock,
                                  )
                                ],
                              )
                            ],
                          )

                      );
                    },
                  ),
              ),
              RaisedButton(
                onPressed: null,
                child: Text('Aller au récapitulatif'),
              ),
            ],
          )
      ),
    );
  }
}