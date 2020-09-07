import 'package:Comif_Server_App/cache/cached_data.dart';
import 'package:Comif_Server_App/database/user_queries.dart';
import 'package:Comif_Server_App/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../database/auth_queries.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


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
        title: Text('Bienvenue sur l\'appli des serveurs de la Comif !'),
      ),
      body: Center(
        child: FormBuilder(
          key: _formKey,
          initialValue: {'email': '', 'password':''},
          autovalidate: true,
          child: Center(
            child: Column(
              children: [
                Container(
                  color: Colors.amber,
                  child: FormBuilderTextField(
                    attribute: 'email',
                    initialValue: 'valentin.pollart@etu.emse.fr',
                    decoration: new InputDecoration(
                      labelText: "Email"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validators: [
                      FormBuilderValidators.email(),
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                Container(
                  color: Colors.amber,
                  child: FormBuilderTextField(
                    attribute: 'password',
                    initialValue: '370468Polval',
                    decoration: new InputDecoration(
                        labelText: "Password"
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validators: [
                      FormBuilderValidators.minLength(6),
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                RaisedButton(
                    onPressed: () => _validate(context),
                    child: Text('Se connecter'),
                )
              ],
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
      final http.Response response = await authUser(value['email'], value['password']);
      if (response.statusCode != 200) {
        throw Exception('Combinaison invalide !');
      }
      final String token = json.decode(response.body)['access_token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("authToken", token);
      CachedData.loadAuthToken();
      User user = await infoUser();
      if (user.status != "admin" && user.status != "server") {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Vous n\'êtes pas serveur à la Comif !')));
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/invoice',
            (route) => false
        );
      }
    }
  }
}