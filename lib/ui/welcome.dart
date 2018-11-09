import 'package:flutter/material.dart';
import 'package:schoober_driver/style/theme.dart' as Theme;
import 'package:schoober_driver/ui/profile.dart';

class Welcome extends StatelessWidget {
  final Map userData;
  final Map profileData;

  Welcome(this.userData,this.profileData);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 75.0),
              child: new Image(
                  width: 250.0,
                  height: 191.0,
                  fit: BoxFit.fill,
                  image: new AssetImage('assets/img/login_logo.png')),
            ),
          ),
          Container(
            width: 250.0,
            height: 1.0,
            color: Colors.grey[400],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(profileData['first_name']+",", style: TextStyle(fontSize: 30.0),),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text("welcome to schoober", style: TextStyle(fontSize: 20.0),),
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
            child: MaterialButton(
                highlightColor: Colors.transparent,
                splashColor: Theme.Colors.loginGradientEnd,
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: "WorkSansBold"),
                  ),
                ),
                onPressed: (){
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new Profile(userData, profileData),
                  );
                  Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route)=> false);
                }),
          ),

        ],
      ),
    );
  }
}
