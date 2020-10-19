import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/screens/shared/account.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

import '../../database/auth_queries.dart';
import 'login.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Changer mon mot de passe'),
        actions: <Widget>[
          FlatButton(
            minWidth: 50,
            color: mainColor2,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AccountScreen()));
            },
            child: Icon(Icons.arrow_back_ios_outlined, color: background,),
          ),
        ],
      ),
      body: Container(
        color: background2,
        child: Center(
          child: FormBuilder(
            key: _formKey,
            initialValue: {'old_password': '', 'new_password': '', 'new_password_verified': ''},
            autovalidate: true,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FormBuilderTextField(
                      attribute: 'old_password',
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintText: "Ancien mot de passe",
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Divider(
                      height: 10,
                      thickness: 3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FormBuilderTextField(
                      attribute: 'new_password',
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintText: "Nouveau mot de passe",
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Divider(
                      height: 10,
                      thickness: 3,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FormBuilderTextField(
                      attribute: 'new_password_verified',
                      textAlign: TextAlign.center,
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        hintText: "Nouveau mot de passe",
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _validate(context),
                    child: Text('Confirmer'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: MainDrawer(),
    );
  }

  _validate(BuildContext context) async {
    var form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      Map<String, dynamic> value = form.value;
      final http.Response response = await changePassword(value['old_password'].toString(), value['new_password'].toString(), value['new_password_verified'].toString());
      if (response.statusCode != 200) {
        debugPrint(response.body.toString());
        throw Exception('Erreur !');
      }
      Navigator.of(context).pushNamedAndRemoveUntil('/account', (route) => false);
    }
  }
}
