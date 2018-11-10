import 'dart:convert';
import 'package:schoober_driver/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:schoober_driver/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final Map userData;
  final Map profileData;

  Profile(this.userData, this.profileData);

  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode txtNameFocus = FocusNode();
  final FocusNode txtSurnameFocus = FocusNode();
  final FocusNode txtGenderFocus = FocusNode();
  final FocusNode txtCellFocus = FocusNode();
  final FocusNode txtStreetFocus = FocusNode();
  final FocusNode txtTownFocus = FocusNode();
  final FocusNode txtProvinceFocus = FocusNode();
  final FocusNode txtCodeFocus = FocusNode();

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtSurname = new TextEditingController();
  TextEditingController txtGender = new TextEditingController();
  TextEditingController txtCell = new TextEditingController();
  TextEditingController txtStreet = new TextEditingController();
  TextEditingController txtTown = new TextEditingController();
  TextEditingController txtProvince = new TextEditingController();
  TextEditingController txtCode = new TextEditingController();

  Map updatedUserData;
  Map updatedProfileData;

  var isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Profile"),
      ),
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child:
                  new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: _buildProfile(context),
                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildProfile(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[

          Container(
            margin: EdgeInsets.only(bottom: 7.0),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
            child: new Container(
                width: 90.0,
                height: 90.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            "https://randomuser.me/api/portraits/lego/0.jpg")
                    )
                )),
          ),
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
                  height: 360.0,
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top:20.0,bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          controller: txtName,
                          focusNode: txtNameFocus,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                          controller: txtSurname,
                          focusNode: txtSurnameFocus,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: "Surname",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                          controller: txtGender,
                          focusNode: txtGenderFocus,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.transgender,
                              color: Colors.black,
                            ),
                            hintText: "Gender",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                          controller: txtCell,
                          focusNode: txtCellFocus,
                          keyboardType: TextInputType.phone,
                          textCapitalization: TextCapitalization.words,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.phone,
                              color: Colors.black,
                            ),
                            hintText: "Cell Number",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                          controller: txtStreet,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.black,
                            ),
                            hintText: "Street Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                          controller: txtTown,
                          focusNode: txtTownFocus,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.black,
                            ),
                            hintText: "Town",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                          controller: txtProvince,
                          focusNode: txtProvinceFocus,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.black,
                            ),
                            hintText: "Province",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
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
                          controller: txtCode,
                          focusNode: txtCodeFocus,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.black,
                            ),
                            hintText: "Postal Code",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              isUpdating ? Center(child: CircularProgressIndicator(),) : Container(
                  margin: EdgeInsets.only(top: 350.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                  boxShadow: <BoxShadow>[
//                    BoxShadow(
//                      color: Colors.blue,
//                      offset: Offset(1.0, 6.0),
//                      blurRadius: 20.0,
//                    ),
//                    BoxShadow(
//                      color: Colors.lightBlue,
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
                          splashColor: Colors.white,
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Text(
                              "Update Profile",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "WorkSansBold"),
                            ),
                          ),
                          onPressed: () {
                            _update();
                          }),
                      Container(
                        width: 250.0,
                        height: 6.0,
                        color: Colors.white,
                      ),
                      MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.white,
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Text(
                              "Return Home",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "WorkSansBold"),
                            ),
                          ),
                          onPressed: () {
                            var route = new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new Home(updatedUserData, updatedProfileData),
                            );
                            Navigator.of(context).pushAndRemoveUntil(
                                route, (Route<dynamic> route) => false);
                          }),
                    ],
                  )


              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    updatedUserData = widget.userData;
    updatedProfileData = widget.profileData;
    getApi();

    txtName.text = updatedProfileData['first_name'];
    txtSurname.text = updatedProfileData['last_name'];
    txtGender.text = updatedProfileData['gender'];
    txtCell.text = updatedProfileData['cell_number'];
    txtStreet.text = updatedProfileData['street_address'];
    txtTown.text = updatedProfileData['town'];
    txtProvince.text = updatedProfileData['province'];
    txtCode.text = updatedProfileData['code'];
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

  Future _update() async {

    setState(() {
      isUpdating = true;
    });

    String name = txtName.text;
    String surname = txtSurname.text;
    String gender = txtGender.text;
    String cell = txtCell.text;
    String street = txtStreet.text;
    String town = txtTown.text;
    String province = txtProvince.text;
    String code = txtCode.text;


    if (name.length < 2) {
      showInSnackBar("Please fill in your name.");
      return;
    }

    if (surname.length < 2) {
      showInSnackBar("Please fill in your surname.");
      return;
    }

    if (cell.length < 10) {
      showInSnackBar("Please fill in a valid cell number.");
      return;
    }

    if (gender.length < 2) {
      showInSnackBar("Please fill in your gender.");
      return;
    }

    if (street.length < 2) {
      showInSnackBar("Please fill in your street address");
      return;
    }

    if (town.length < 2) {
      showInSnackBar("Please fill in your town.");
      return;
    }

    if (province.length < 2) {
      showInSnackBar("Please fill in your province.");
      return;
    }

    if (code.length < 2) {
      showInSnackBar("Please fill in your postal code.");
      return;
    }


    try {
      await http.post(Constants.updateProfile, body: {
        'api_key': apiKey,
        'user_id': widget.userData['user_id'],
        'first_name': name,
        'last_name': surname,
        'gender': gender,
        'cell_number': cell,
        'street_address': street,
        'town': town,
        'province': province,
        'code': code
      }).then((response) async {

        setState(() {
          isUpdating = false;
        });

        var message = json.decode(response.body)['response'];
        if (message['status'] == '200') {
          showInSnackBar("Your profile was successfully updated.");

          setState(() {
            updatedProfileData = message['profile'];
          });
        } else {
          showInSnackBar(message['message']);
        }
      });
    } catch (e) {
      setState(() {
        isUpdating = false;
      });

      showInSnackBar("Please check your internet connection.");
    }
  }

}
