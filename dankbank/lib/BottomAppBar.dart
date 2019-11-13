import 'LoginPage.dart';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Account.dart';
import 'Favorites.dart';
import 'package:firebase_auth/firebase_auth.dart';


class BottomBar extends StatelessWidget {

  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.purple[900],
      child: new Row (
       mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

          IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                 context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }
          ),
          IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favorites()),
                );
              }
          ),
          IconButton(
              icon: Icon(Icons.account_circle),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginOrProfile()),
                );
              }
          )

        ],
      ),
    );
  }


}

class LoginOrProfile extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
          if (snapshot.hasData){
            FirebaseUser user = snapshot.data;
            //print(user.email);// this is your user instance
            /// is because there is user already logged
            return Account(user);
          }
          /// other way there is no user logged.
          return LoginPage();
        }
    );
  }
}