import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scanyourway/picker/image_picker.dart';

class LoginForm extends StatefulWidget {
  LoginForm(this.submitFn, this.isLoading);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
//this signals to dart that some form of state will be managed with this key
  final _formKey = GlobalKey<FormState>();
  //_isLogin checks if we are sign up or login mode
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _tryLogin() {
    final isValid = _formKey.currentState.validate();
    //close the soft keyboard as soon as form has been submitted
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      //go through all form fields and trigger onSaved
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
      //use values to send login request to firebase
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 90),
        child: Card(
          margin: EdgeInsets.all(20),
          child: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  //set the key of form
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (!_isLogin) UserImagepicker(_pickedImage),
                      TextFormField(
                        key: ValueKey('email'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email address',
                        ),
                        //save entered value
                        onSaved: (value) {
                          _userEmail = value;
                        },
                      ),
                      //only if we are not in login mode add username
                      if (!_isLogin)
                        TextFormField(
                          key: ValueKey('username'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 4) {
                              return 'Please enter at least 4 characters';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Username'),
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      TextFormField(
                        key: ValueKey('password'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Password must be at least 7 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        onSaved: (value) {
                          _userPassword = value;
                        },
                      ),
                      SizedBox(height: 12),
                      if (widget.isLoading)
                        CircularProgressIndicator(),
                      if (!widget.isLoading)
                        RaisedButton(
                          child: Text(_isLogin ? 'Login' : 'Signup'),
                          onPressed: _tryLogin,
                        ),
                      if (!widget.isLoading)
                        FlatButton(
                            //if islogin is true switch to signup mode
                            child: Text(_isLogin
                                ? 'Create new account'
                                : 'I already have an account'),
                            onPressed: () {
                              setState(
                                () {
                                  _isLogin = !_isLogin;
                                },
                              );
                            })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//problem when i went on create new account it put fix by adding a key so the bug is fixed
//dont need provider package firebase sdk manages all relevant state for us
//bad user experience implementin 318 blank space on email use.trim to remove any white space
