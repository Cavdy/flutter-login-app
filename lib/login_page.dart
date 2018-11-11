import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginapp/authentication.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType {
  login,
  register
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  FormType _formType = FormType.login;

  final _formKey = new GlobalKey<FormState>();

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _validateAndSubmit() async {
    if(_validateAndSave()) {
      try {
        if(_formType == FormType.login) {
          String userId = await widget.auth
              .signInWithEmailAndPassword(_email, _password);
          print("Signed In $userId");
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);
          print("Registered User $userId");
        }
        widget.onSignedIn();
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void _moveToRegister() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void _moveToLogin() {
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _formField(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                          child: Icon(FontAwesomeIcons.google, color: Colors.white),
                          color: Color(0xFFdd4b39),
                          onPressed: null
                      ),
                      SizedBox(width: 5.0,),
                      RaisedButton(
                          child: Icon(FontAwesomeIcons.twitter, color: Colors.white),
                          color: Color(0xFF00aced),
                          onPressed: null
                      ),
                      SizedBox(width: 5.0,),
                      RaisedButton(
                          child: Icon(FontAwesomeIcons.facebook, color: Colors.white,),
                          color: Color(0xFF3b5998),
                          onPressed: null
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formField() {
    if(_formType == FormType.login) {
      return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.email, color: Colors.green),
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Email Address", labelStyle: TextStyle(color: Colors.green,)),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  validator: (value) => value.isEmpty ? "Email Address can't empty" : null,
                  onSaved: (value) => _email = value,
                ),
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.green),
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Password", labelStyle: TextStyle(color: Colors.green,)),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  maxLength: 10,
                  obscureText: true,
                  validator: (value) => value.isEmpty ? "Password can't be empty" : null,
                  onSaved: (value) => _password = value,
                ),
              ),
              RaisedButton(
                  child: Text("Login", style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  onPressed: _validateAndSubmit
              ),
              FlatButton(
                child: Text("Don't have an account? Sign up", style: TextStyle(color: Colors.green),),
                onPressed: _moveToRegister,
              )
            ],
          ),
        ),
      );
    } else {
      return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.email, color: Colors.blue),
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Email Address", labelStyle: TextStyle(color: Colors.blue,)),
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  validator: (value) => value.isEmpty ? "Email Address can't empty" : null,
                  onSaved: (value) => _email = value,
                ),
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Colors.blue),
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Password", labelStyle: TextStyle(color: Colors.blue,)),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  maxLength: 10,
                  obscureText: true,
                  validator: (value) => value.isEmpty ? "Password can't be empty" : null,
                  onSaved: (value) => _password = value,
                ),
              ),
              RaisedButton(
                  child: Text("SignUp", style: TextStyle(color: Colors.white),),
                  color: Colors.blue,
                  onPressed: _validateAndSubmit
              ),
              FlatButton(
                child: Text("Have an account? Login", style: TextStyle(color: Colors.blue),),
                onPressed: _moveToLogin,
              )
            ],
          ),
        ),
      );
    }
  }
}
