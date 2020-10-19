import 'dart:convert';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/auth_queries.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Bienvenue sur l\'appli des serveurs de la Comif !'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Container(
            color: background,
            child: Center(
              child: FormBuilder(
                key: _formKey,
                initialValue: {'email': '', 'password': ''},
                autovalidate: true,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset('assets/icons/launcher_icon.png',
                            width: 128, height: 128),
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
                          attribute: 'email',
                          textAlign: TextAlign.center,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 5),
                            hintText: "Email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validators: [
                            FormBuilderValidators.email(),
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
                          attribute: 'password',
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 5),
                              hintText: "Password"),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: () => _validate(context),
                        child: Text('Se connecter'),
                      ),
                      RaisedButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil('/forgot_password', (route) => false),
                        child: Text('Mot de passe oublié ?'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }

  _validate(BuildContext context) async {
    var form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      Map<String, dynamic> value = form.value;
      final http.Response response =
          await authUser(value['email'], value['password']);
      if (response.statusCode != 200) {
        Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text("Mot de passe erroné !", textAlign: TextAlign.center,)
            )
        );
        return;
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = json.decode(response.body)['access_token'];
      prefs.setString("authToken", token);
      await SharedPrefs.loadAuthToken();
      User user = await infoUser();
      prefs.setInt("userId", user.id);
      prefs.setBool(
          "isAdmin", user.status == "admin" || user.status == "seller");
      await SharedPrefs.loadUser();
      if (SharedPrefs.isAdmin) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/account', (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/main', (route) => false);
      }
    }
  }
}
