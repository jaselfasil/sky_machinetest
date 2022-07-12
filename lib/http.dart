import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String baseUrl = "https://api.github.com/users/";
const String msgForNoInternet = "Check your internet and try again";
const String noDataMsg = "No Data Found";
const String msgFor500Error = "Internal error";
const String msgForTimeOut = "Network is unreachable";
const String msgForUnknownError = "Something went wrong";

// const kRowColorEven = Color(0xFFF9F9F9);
// const kRowColorOdd = Colors.transparent;

enum ErrorType { noInternet, fiveHundred, networkDown }

class Http {
  Connectivity _connectivity;
  bool useSnackBar = false;

  Future<dynamic> getRequest(String _url, BuildContext context,
      {required GlobalKey<ScaffoldState> scaffoldKey, headers}) async {
    if (await _checkInternetConnectivity()) {
      print("urllll$_url");
      late http.Response _response;
      try {
        _response = await http.get(Uri.parse(_url), headers: headers);
        print("resppppp${_response.body}");
        print("status code${_response.statusCode}");
        if (_response.statusCode == 500) {
          // _getLogicalError(context);
          return ErrorType.fiveHundred;
        } else {
          return _response.body;
        }
      } catch (e) {
        print(e);
        print("status code${_response.statusCode}");
        if (_response.statusCode == 500) {
          // _getLogicalError(context);
          return ErrorType.fiveHundred;
        } else if (useSnackBar) {
          displaySnackBar(scaffoldKey, msgFor500Error, onPressed: () {
            getRequest(_url, context, scaffoldKey: scaffoldKey);
          });
        }
        // throw Exception;
      }
    } else {
      displaySnackBar(scaffoldKey, msgForNoInternet, onPressed: () {
        getRequest(_url, context, scaffoldKey: scaffoldKey);
      });
    }
  }


  Future<bool> _checkInternetConnectivity() async {
    var result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<dynamic> displaySnackBar(GlobalKey<ScaffoldState> key, String msg,
      {required VoidCallback onPressed}) async {
    key.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        // backgroundColor: Colors.red,
        backgroundColor: Color(0xff273647),
        content: Text(
          msg,
          textAlign: TextAlign.start,
        ),
        duration: Duration(seconds: 5),
        action: onPressed == null
            ? null
            : SnackBarAction(
                label: 'Retry',
                onPressed: onPressed,
              ),
      ));
  }

  Http._internal() : _connectivity = new Connectivity();
  static Http? _singleton;

  static Http get instance {
    if (_singleton == null) {
      _singleton = Http._internal();
    }
    return _singleton!;
  }
}
