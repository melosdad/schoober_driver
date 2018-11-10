import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:schoober_driver/style/theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'package:schoober_driver/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoober_driver/ui/login.dart';

class Password extends StatefulWidget {
  final Map userProfile;
  Password(this.userProfile);
  @override
  _PasswordState createState() => new _PasswordState();
}

class _PasswordState extends State<Password> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode focusNewPassword = FocusNode();
  final FocusNode focusConfirmNewPassword = FocusNode();

  TextEditingController txtNewPassword = new TextEditingController();
  TextEditingController txtConfirmNewPassword = new TextEditingController();

  @override
  void initState() {
    getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height >= 775.0
                ? MediaQuery
                .of(context)
                .size
                .height
                : 775.0,
            decoration: new BoxDecoration(
//              gradient: new LinearGradient(
//                  colors: [
//                    Theme.Colors.loginGradientStart,
//                    Theme.Colors.loginGradientEnd
//                  ],
//                  begin: const FractionalOffset(0.0, 0.0),
//                  end: const FractionalOffset(1.0, 1.0),
//                  stops: [0.0, 1.0],
//                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: new Image(
                      width: 250.0,
                      height: 191.0,
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/img/login_logo.png')),
                ),
                Expanded(
                  flex: 1,
                  child:
                  new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: _buildNewPassword(context),
                  ),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewPassword(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNewPassword,
                          controller: txtNewPassword,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "New Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusConfirmNewPassword,
                          controller: txtConfirmNewPassword,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Confirm New Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                  boxShadow: <BoxShadow>[
//                    BoxShadow(
////                      color: Theme.Colors.loginGradientStart,
//                      offset: Offset(1.0, 6.0),
//                      blurRadius: 20.0,
//                    ),
//                    BoxShadow(
////                      color: Theme.Colors.loginGradientEnd,
//                      offset: Offset(1.0, 6.0),
//                      blurRadius: 20.0,
//                    ),
//                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.lightBlue
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child:

                    new Column(
                      children: <Widget>[

                        MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.Colors.loginGradientEnd,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Text(
                                "Save Password",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              _newPassword();
                            }),
                        Container(
                          width: 250.0,
                          height: 6.0,
                          color: Colors.white,
                        ),
                        MaterialButton(
                            highlightColor: Colors.transparent,
                            splashColor: Theme.Colors.loginGradientEnd,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () {
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) => new Login(),
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  route, (Route<dynamic> route) => false);
                            })

                      ],
                    )

                ,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 5),
    ));
  }

  var apiKey = "";

  getApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    apiKey = preferences.getString("api_key");
  }


  _newPassword() async {
    String newPassword = txtNewPassword.text;
    String confirmNewPassword = txtConfirmNewPassword.text;

    if (newPassword.length < 5) {
      showInSnackBar("Please fill in your password, minimum length is 5 charaters.");
      return;
    }

    if (confirmNewPassword != newPassword) {
      showInSnackBar("The passwords you have entered do not match.");
      return;
    }

    try {
      await http.post(Constants.resetPasswordUrl+"?api_key="+apiKey, body: {
        'password': newPassword,
        'user_id': widget.userProfile['user_id']
      }).then((response) async {
        var message = json.decode(response.body)['response'];
        if (message['status'] == '200') {
          showInSnackBar("Your new password was successfully saved. You can now login.");
        } else {
          showInSnackBar(message['message']);
        }
      });
    } catch (e) {
      showInSnackBar("Please check your internet connection.");
      print(e.toString());
    }
  }
}
