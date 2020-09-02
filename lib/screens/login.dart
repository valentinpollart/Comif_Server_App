import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../database/auth_queries.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class LoginScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FormBuilder(
          key: _formKey,
          initialValue: {'email': '', 'password':''},
          autovalidate: true,
          child: Center(
            child: Column(
              children: [
                Container(
                  child: FormBuilderTextField(
                    attribute: 'email',
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
                  child: FormBuilderTextField(
                    attribute: 'password',
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
      if (response.statusCode != 201) {
        throw Exception('Authentication failed !');
      }
      final String token = json.decode(response.body)['access_token'];

    }
  }
}