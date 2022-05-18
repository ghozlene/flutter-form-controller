// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MyFlutterForm(),
      ),
    );
  }
}

class MyFlutterForm extends StatefulWidget {
  @override
  _MyFlutterFormState createState() => _MyFlutterFormState();
}

class _MyFlutterFormState extends State<MyFlutterForm> {
  //form key here
  final _formKey = GlobalKey<FormState>();
  // variable to enable auto validating of theform
  bool _autoValidate = true;
  // variable to enable toggling between showing and hiding password
  final distController = TextEditingController();
  final outPutController = TextEditingController();
  final dosageController = TextEditingController();
  final TextEditingController exposureController = TextEditingController();
  final L = 89;
  final pi = 3.143;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    distController.dispose();
    outPutController.dispose();
    dosageController.dispose();
    exposureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 80),
      alignment: Alignment.center,
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(
            right: 20.0,
            left: 20.0,
            top: 40,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffix: Text('cm'),
                      suffixStyle: const TextStyle(color: Colors.green),
                      labelText: 'Distance',
                    ),
                    controller: distController,
                    keyboardType: TextInputType.phone,
                    validator: validateFloat,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[. 0-9]'))
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        suffix: Text('W'),
                        suffixStyle: const TextStyle(color: Colors.green),
                        labelText: 'Output power'),
                    controller: outPutController,
                    keyboardType: TextInputType.phone,
                    validator: validateFloat,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[. 0-9]'))
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffix: Text('J/cm^2'),
                      suffixStyle: const TextStyle(color: Colors.green),
                      labelText: 'Required dosage',
                    ),
                    controller: dosageController,
                    keyboardType: TextInputType.phone,
                    validator: validateFloat,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[. 0-9]'))
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixStyle: const TextStyle(color: Colors.green),
                      suffix: Text('min'),
                      labelText: 'Exposure time',
                    ),
                    controller: exposureController,
                    keyboardType: TextInputType.phone,
                    validator: validateFloat,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[. 0-9]'))
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        if (exposureController.text == "") {
                          exposureController.text = ((2 *
                                      pi *
                                      L *
                                      int.parse(distController.text) *
                                      int.parse(dosageController.text)) /
                                  int.parse(outPutController.text))
                              .toString();
                          if (_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Form Validated, No errors'),
                            ));
                          }
                        }
                      },
                      textColor: Colors.white,
                      elevation: 2.0,
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Calculate exposure time',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// regex method to validate user phone number
  String validateFloat(String value) {
    String pattern = r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter a number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid a number';
    }
    return null;
  }
}
