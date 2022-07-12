import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sky_machinetest/Providers/UserProvider.dart';
import 'package:sky_machinetest/Repositories.dart';

class UserProfile extends StatefulWidget {
  String? uName;

  UserProfile(this.uName);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   // fetchUser();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var textStyle = TextStyle(fontFamily: 'Lato', fontSize: width * 0.035,color: Colors.white);
    final f = new DateFormat.yMMMMd("en_US");
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Consumer<UserProvider>(
        builder: (_, value, __) {
          // ignore: unnecessary_null_comparison
          return value.getUserData == null
              ? Center(child: CupertinoActivityIndicator())
              :  Stack(
            children: [
              Positioned(
                child:Padding(
                  padding:  EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text(
                      'Joined at ${f.format(DateTime.parse((value.getUserData.joinDate.toString())))}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 15,
                          color: Colors.grey[400]),
                    ),
                  ),
                ),
              ),
              ListView(
                children: [
                  ColoredBox(
                    color: Colors.white10,
                    child: Padding(
                      padding:  EdgeInsets.only(top: height * 0.05,left: width * 0.035),
                      child: Row(
                        children: [
                          Image.network(value.getUserData.avatar,
                            width: width * 0.15,
                            height: height * 0.15,),
                          SizedBox(width: 15,),
                          Text(value.getUserData.username.toString(), style: textStyle,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05,),
                  ColoredBox(
                    color: Colors.white10,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset('assets/images/user-shield.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Followings',
                                      style: textStyle,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                value.getUserData.following.toString(),
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset('assets/images/github-2.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Followers',
                                      style: textStyle,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                value.getUserData.followers.toString(),
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => Repositories(value.getUserData.username)));
                          },

                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => Repositories(value.getUserData.username)));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                          'assets/images/user-male-circle.png'),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text('Public Repositries',
                                            style: textStyle),
                                      ),
                                    ],
                                  ),
                                  Text(value.getUserData.publicRepos.toString(),
                                      /*user.user.public_repo.toString(),*/
                                      style: textStyle.copyWith(fontSize: width * 0.030)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )


                ],
              ),
            ],
          );
        },
      ),
    );
  }
 /* void fetchUser() {
    Provider.of<UserProvider>(context, listen: false)
        .sentRequestGetUser(context, _scaffoldKey, widget.uName!);
  }*/
}
