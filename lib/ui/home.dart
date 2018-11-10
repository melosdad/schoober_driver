import 'package:flutter/material.dart';
import 'package:schoober_driver/ui/profile.dart';
import 'package:schoober_driver/ui/login.dart';

class Home extends StatefulWidget {
  final Map userData;
  final Map profileData;

  Home(this.userData, this.profileData);
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new Login(),
          );
          Navigator.of(context).pushAndRemoveUntil(route,(Route<dynamic> route)=> false);
        }),
        title: new Text("Home"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.account_circle), onPressed: (){
            var route = new MaterialPageRoute(
              builder: (BuildContext context) => new Profile(widget.userData, widget.profileData),
            );
            Navigator.of(context).pushAndRemoveUntil(route,(Route<dynamic> route)=> false);
          })
        ],
      ),
    );
  }
}
