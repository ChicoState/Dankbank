import 'package:dankbank/BottomAppBar.dart';
import 'package:dankbank/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {
  final FirebaseUser user;
  Account(this.user);
  @override
  AccountState createState() {
    return AccountState(user);
  }
}
class AccountState extends State<Account> {
  final FirebaseUser user;
  AccountState(this.user);
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Account'),
        ),
        body: Center (
          child: Container(
            child: Padding (
              padding: const EdgeInsets.all(36.0),
                  child: Column (
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          size: 100,
                        ),
                        Text(
                          //Change to username
                           user.email
                        ),
                        FlatButton(
                          color: Colors.purple[900],
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Logout'
                          ),
                          onPressed: (){
                            _signOut();
                            Navigator.push(
                              context,MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            );
                          },
                        )
                      ]
                  ),
              ),
            ),
          ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

