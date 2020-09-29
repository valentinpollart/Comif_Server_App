import 'dart:convert';

import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:Comif_Server_App/ui/texts/main_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

import '../../database/auth_queries.dart';
import 'login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Mot de passe oublié'),
        actions: <Widget>[
          FlatButton(
            minWidth: 50,
            color: mainColor2,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen()));
            },
            child: Icon(Icons.arrow_back_ios_outlined, color: background,),
          ),
        ],
      ),
      body: Container(
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
                    child: MainText(text: 'Saisissez l\'adresse mail que vous avez fourni sur votre feuille de cotisation et un mail vous sera envoyé automatiquement avec un lien pour (ré)initialiser votre mot de passe.')
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
    );
  }

  _validate(BuildContext context) async {
    var form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      Map<String, dynamic> value = form.value;
      final http.Response response =
      await forgotPassword(value['email']);
      if (response.statusCode != 200) {
        throw Exception('Combinaison invalide !');
      }
    }
  }
}
