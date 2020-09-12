import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:Comif_Server_App/ui/texts/prices.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
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