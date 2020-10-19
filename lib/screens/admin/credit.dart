import 'package:Comif_Server_App/database/transaction_queries.dart';
import 'package:Comif_Server_App/ui/drawers/main_drawer.dart';
import 'package:Comif_Server_App/ui/texts/app_bar_text.dart';
import 'package:Comif_Server_App/ui/widgets/client_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Comif_Server_App/ui/colors/colors.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class CreditScreen extends StatefulWidget {
  @override
  _CreditScreenState createState() =>
      _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen>{
  int _clientId;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    if (_clientId == null) {
      return Scaffold(
        backgroundColor: background2,
          appBar: AppBar(
            title: AppBarText('Quel compte on recharge ?'),
            backgroundColor: mainColor,
            
          ),
          body: ClientList(
              clientSelected: (id) => {
                setState(() {
                  _clientId = id;
                })
              },
          ),
          drawer: MainDrawer());
    } else {
      return Scaffold(
          backgroundColor: background2,
          appBar: AppBar(
            title: Text('De combien on recharge ?'),
            backgroundColor: mainColor,
            actions: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    _clientId = null;
                  });
                },
                child: Icon(Icons.arrow_back_ios_outlined),
              )
            ],
          ),
          body: Container(
            color: background,
            child: Center(
              child: FormBuilder(
                key: _formKey,
                autovalidate: true,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 3,
                              color: mainColor,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: FormBuilderTextField(
                          attribute: 'amount',
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5),
                              hintText: "Montant à créditer"
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: () => _validate(context),
                        child: Text('Valider'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          drawer: MainDrawer()
      );
    }
  }

  _validate(context) {
    var form = _formKey.currentState;
    form.save();
    if (form.validate()) {
      Map<String, dynamic> value = form.value;
      postCredit(_clientId, (double.parse(value["amount"]) * 100).toInt());
      _clientId = null;
      Navigator.of(context).pushNamedAndRemoveUntil('/main', (route) => false);
    }
  }
}