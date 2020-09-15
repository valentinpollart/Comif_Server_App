import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';

typedef void ClientSelectedCallback(int id);

class ClientList extends StatelessWidget {
  final ClientSelectedCallback clientSelected;

  ClientList({
    Key key,
    @required this.clientSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      body: SafeArea(
        child: SearchBar<User>(
          minimumChars: 1,
          onSearch: searchUser,
          searchBarStyle: SearchBarStyle(backgroundColor: background3),
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
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: MainText(
                        text: user.firstName + ' ' + user.lastName,
                        size: 25,
                        weight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding:  EdgeInsets.all(15),
                      child: MainText(
                        text: displayPrice(user.balance),
                        size: 22,
                        weight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  clientSelected(user.id);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
