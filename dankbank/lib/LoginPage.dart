import 'Account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'RegistrationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'BottomAppBar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Login'),
      ),
      body: Center(
          child: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Form(
                    key: _formStateKey,
                    autovalidate: true,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: TextFormField(
                            onSaved: (value) {
                              _emailId = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailIdController,
                            decoration: InputDecoration(
                              focusedBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.deepPurple,
                                    width: 2,
                                    style: BorderStyle.solid),
                              ),
                              labelText: "Email",
                              icon: Icon(
                                Icons.email,
                                color: Colors.purple,
                              ),
                              //fillColor: Colors.white,
                              labelStyle: TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                          child: TextFormField(
                            onSaved: (value) {
                              _password = value;
                            },
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.deepPurple,
                                      width: 2,
                                      style: BorderStyle.solid)),
                              labelText: "Password",
                              icon: Icon(
                                Icons.lock,
                                color: Colors.purple,
                              ),
                              //fillColor: Colors.white,
                              labelStyle: TextStyle(
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
//                  (errorMessage != ''
                      //? Text(
                   //       errorMessage,
                    //      style: TextStyle(color: Colors.red),
                    //    )
 //                     : Container()),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.purple,
                            ),
                          ),
                          onPressed: () {
                            if (_formStateKey.currentState.validate()) {
                              _formStateKey.currentState.save();
                              signIn(_emailId, _password).then((user) {
                                if (user != null) {
                                  print('Logged in successfully.');
                                  setState(() {
                                   // successMessage =
                                 //       'Logged in successfully.\nYou can now navigate to Home Page.';
                                    Navigator.push(
                                        context,MaterialPageRoute(
                                    builder: (context) => Account(user)),
                                  );
                                  });
                                } else {
                                  print('Error while Login.');
                                }
                              });
                            }
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.purple,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => RegistrationPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          (successMessage != ''
              ? Text(
                  successMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.green),
                )
              : Container()),
          (!isGoogleSignIn
              ? RaisedButton(
                  child: Text('Google Login'),
                  onPressed: () {
                    googleSignin(context).then((user) {
                      if (user != null) {
                        print('Logged in successfully.');
                        setState(() {
                          isGoogleSignIn = true;
                          successMessage =
                              'Logged in successfully.\nEmail : ${user.email}\nYou can now navigate to Home Page.';
                        });

                      } else {
                        print('Error while Login.');
                      }
                    });
                  },
                )
              : RaisedButton(
                  child: Text('Google Logout'),
                  onPressed: () {
                    googleSignout().then((response) {
                      if (response) {
                        setState(() {
                          isGoogleSignIn = false;
                          successMessage = '';
                        });
                      }
                    });
                  },
                )),
        ],
      )),
      bottomNavigationBar: BottomBar(),
    );
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    try {
      FirebaseUser user = (await auth.signInWithEmailAndPassword(
          email: email, password: password)).user;

      assert(user != null);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      return user;
    } catch (e) {
      handleError(e);
      return null;
    }
  }

  Future<FirebaseUser> googleSignin(BuildContext context) async {
    FirebaseUser currentUser;
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await auth.signInWithCredential(credential)).user;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      currentUser = await auth.currentUser();
      assert(user.uid == currentUser.uid);
      print(currentUser);
      print("User Name  : ${currentUser.displayName}");
    } catch (e) {
      handleError(e);
    }
    return currentUser;
  }

  Future<bool> googleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    return true;
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'User Not Found!!!';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Wrong Password!!!';
        });
        break;
    }
  }

}
