import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sky_machinetest/Model/User.dart';
import 'package:sky_machinetest/UserProfile.dart';

import '../http.dart';

class UserProvider with ChangeNotifier {


  var http = Http.instance;


  User userResponse;


  Future<dynamic> sentRequestGetUser(BuildContext context,GlobalKey<ScaffoldState> key,String username) async {
    String url = "${baseUrl + username} ";
    try {
      userResponse = userRespFromJson(
          await http.getRequest(url, context, scaffoldKey: key));
      notifyListeners();
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()));
    } catch (e) {
      print(e);
    }
  }




  User get getUserData{
    return userResponse;
  }


}