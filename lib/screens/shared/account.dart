import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Mon compte'),
      ),
      body: Container(
        color: background2,
        child: Center(
          child: FutureBuilder(
              future: infoUser(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  User user = snapshot.data;
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: user.balance > 0 ? Image.asset('assets/icons/positive_icon.png',
                            width: 200, height: 200) : Image.asset('assets/icons/negative_icon_alternative.jpg',
                            width: 200, height: 200)
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Divider(
                          color: font4,
                          thickness: 3,
                        ),
                      ),
                      Container(
                        child: MainText(
                          text: "Balance",
                          color: font4,
                          size: 40,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 15),
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: mainColor,
                          border: Border.all(
                            width: 3,
                            color: font4,
                          ),
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                        ),
                        child: MainText(
                          text: displayPrice(user.balance),
                          size: 40,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Divider(
                          color: font4,
                          thickness: 3,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: MainText(
                          text: "Dépenses",
                          color: font4,
                          size: 40,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  border: Border.all(
                                    width: 3,
                                    color: font4,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    MainText(
                                      text: "Jour",
                                      size: 30,
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                      child: Divider(
                                        color: drawing,
                                        thickness: 1,
                                      ),
                                    ),
                                    MainText(
                                      text: displayPrice(user.expensesDay),
                                      size: 30,
                                      alignment: TextAlign.center,
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  border: Border.all(
                                    width: 3,
                                    color: font4,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(children: [
                                  MainText(
                                    text: "Semaine",
                                    size: 30,
                                  ),
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                    child: Divider(
                                      color: drawing,
                                      thickness: 1,
                                    ),
                                  ),
                                  MainText(
                                    text: displayPrice(user.expensesWeek),
                                    size: 30,
                                    alignment: TextAlign.center,
                                  ),
                                ])),
                          ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  border: Border.all(
                                    width: 3,
                                    color: font4,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(children: [
                                  MainText(
                                    text: "Mois",
                                    size: 30,
                                  ),
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                    child: Divider(
                                      color: drawing,
                                      thickness: 1,
                                    ),
                                  ),
                                  MainText(
                                    text: displayPrice(user.expensesMonth),
                                    size: 30,
                                    alignment: TextAlign.center,
                                  ),
                                ])),
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  );
                }
              })
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
