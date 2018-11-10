import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:schoober_driver/style/theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'package:schoober_driver/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:schoober_driver/ui/code.dart';



class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => new _ForgotState();
}

class _ForgotState extends State<Forgot> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FocusNode myFocusNodeEmailForgot = FocusNode();

  TextEditingController forgotEmailController = new TextEditingController();

  var isChecking = false;
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
                    child: _buildForgot(context),
                  ),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgot(BuildContext context) {
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
//                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailForgot,
                          controller: forgotEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isChecking ? Center(child: CircularProgressIndicator(),) : Container(
                margin: EdgeInsets.only(top: 70.0),
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
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: Theme.Colors.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: (){
                      _forgot();
                    }),
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

   getApi() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    apiKey = preferences.getString("api_key");
  }


   _forgot() async{

     setState(() {
       isChecking = true;
     });

    String email = forgotEmailController.text;

    if(email.length < 2 || email.contains(".") == false || email.contains("@") == false ){
      setState(() {
        isChecking = false;
      });
      showInSnackBar("Please fill in a valid email address.");
      return;
    }

    try{
      await http.post(Constants.forgotPasswordUrl, body : {
        'api_key' : apiKey,
        'email': email
      }).then((response) async{

        setState(() {
          isChecking = false;
        });
        var message = json.decode(response.body)['response'];

        if(message['status'] == '200'){
          Map userProfile = message['profile'];

          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new Code(userProfile),
          );
          Navigator.of(context).push(route);

        }else{
          showInSnackBar(message['message']);
        }
      });
    }catch (e){
      setState(() {
        isChecking = false;
      });
      showInSnackBar("Please check your internet connection.");

    }

  }
}
