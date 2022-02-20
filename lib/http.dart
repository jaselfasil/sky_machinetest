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

  /*Future<dynamic> postRequest(String _url, Map _params, BuildContext context,
      {GlobalKey<ScaffoldState> scaffoldKey}) async {
    if (await _checkInternetConnectivity()) {


      http.Response _response;
      try {
        _response = await http.post(
          _url,
          body: _params,
        );
        print("resppppp${_response}");
        if (_response?.statusCode == 500) {
          // _getLogicalError(context);
          final msg = json.decode(_response.body)['Message'];
          if (msg == "Mobile number not registered") {
            *//*if (!isShowingAlert) {
              if (await showAlert(
                  context: context, sec: "OK", msg: msg, status: false)) {}
            }*//*
          }
          *//*displaySnackBar(scaffoldKey, json.decode(_response.body)['Message'], onPressed: () {
            postRequest(_url, _params, context, scaffoldKey: scaffoldKey);
          });*//*
        } else {
          return _response.body;
        }
      } catch (e) {
        print(e);
        print("status code${_response?.statusCode}");
        if (_response?.statusCode == 500) {
          // _getLogicalError(context);
          // return ErrorType.fiveHundred;
          if (useSnackBar) {
            displaySnackBar(scaffoldKey, msgFor500Error, onPressed: () {
              postRequest(_url, _params, context, scaffoldKey: scaffoldKey);
            });
          }

        } else {
          // _getNetworkDown(context);
          // return ErrorType.networkDown;

          if (useSnackBar) {
            displaySnackBar(scaffoldKey, msgForTimeOut, onPressed: () {
              postRequest(_url, _params, context, scaffoldKey: scaffoldKey);
            });

          }
        }
        // throw Exception;
      }
    } else {
      print("called msg for no intrnet");
      // _displaySnackBar(scaffoldKey);
      //  return ErrorType.noInternet;

      if (useSnackBar) {
        displaySnackBar(scaffoldKey, msgForNoInternet, onPressed: () {
          postRequest(_url, _params, context, scaffoldKey: scaffoldKey);
        });
      }
    }
  }
*/

  Future<dynamic> getRequest(String _url, BuildContext context,
      {GlobalKey<ScaffoldState> scaffoldKey, Map headers}) async {
    if (await _checkInternetConnectivity()) {
      print("urllll$_url");
      http.Response _response;
      try {
        _response = await http.get(_url, headers: headers);
        print("resppppp${_response.body}");
        print("status code${_response.statusCode}");
        if (_response?.statusCode == 500) {
          // _getLogicalError(context);
          return ErrorType.fiveHundred;
        } else {
          return _response.body;
        }
      }
      catch (e) {
        print(e);
        print("status code${_response?.statusCode}");
        if (_response?.statusCode == 500) {
          // _getLogicalError(context);
          return ErrorType.fiveHundred;
        } else if (useSnackBar) {
            displaySnackBar(scaffoldKey, msgFor500Error, onPressed: () {
              getRequest(_url, context, scaffoldKey: scaffoldKey);
            });
        }
        // throw Exception;
      }
    }else{
      displaySnackBar(scaffoldKey, msgForNoInternet, onPressed: () {
        getRequest(_url, context, scaffoldKey: scaffoldKey);
      });
    }
  }

  bool isShowingAlert = false;





  Future<bool> _checkInternetConnectivity() async {
    var result = await _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future<bool> displaySnackBar(GlobalKey<ScaffoldState> key, String msg,
      {VoidCallback onPressed}) async {
    key.currentState
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
  static Http _singleton;

  static Http get instance {
    if (_singleton == null) {
      _singleton = Http._internal();
    }
    return _singleton;
  }
}
