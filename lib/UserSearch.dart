import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sky_machinetest/Providers/UserProvider.dart';

class UserSearch extends StatefulWidget {
  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  TextEditingController _controller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height * 0.2,
          ),
          Image.asset(
            "assets/images/git.png",
            color: Colors.white,
            width: width * 0.25,
            height: height * 0.1,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            "Github",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8),
            child: Container(
                // margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                height: 50.0,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(10.0))),
                child: TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      // searchProduct();
                      fetchUser();
                    },
                    controller: _controller,
                    autofocus: false,
                    style: new TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search), onPressed: fetchUser),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search User',
                      // contentPadding:  EdgeInsets.all(
                      //     10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.white),
                        borderRadius: new BorderRadius.circular(25.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(25.7)),
                    ))),
          ),
        ],
      ),
    );
  }

  void fetchUser() {
    if (_controller.text.isEmpty || _controller.text == "") {
      Fluttertoast.showToast(
          msg: "Please enter a name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    } else {
      Provider.of<UserProvider>(context, listen: false)
          .sentRequestGetUser(context, _scaffoldKey, _controller.text);
      _controller.clear();
    }
  }
}
