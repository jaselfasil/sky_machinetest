import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sky_machinetest/Model/Repo.dart';

import '../http.dart';

class RepositriesProvider with ChangeNotifier {


  var http = Http.instance;

  List<Repositries>? UserRepo;


  Future<dynamic> sentRequestGetUserRepo(BuildContext context,GlobalKey<ScaffoldState> key,String username) async {
    String url = "${baseUrl + username + "/repos"}";
    try {
      UserRepo = listAllRepoRespFromJson(
          await (http.getRequest(url, context, scaffoldKey: key)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }




  List<Repositries>? get getUserRepoData{
    return UserRepo;
  }


}