import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import 'Providers/RepositoryProvider.dart';

class Repositories extends StatefulWidget {
  String? uName;

  Repositories(this.uName);

  @override
  _RepositoriesState createState() => _RepositoriesState();
}

class _RepositoriesState extends State<Repositories> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final f = new DateFormat.yMMMMd("en_US");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var textStyle = TextStyle(fontFamily: 'Lato', fontSize: width * 0.035,color: Colors.white);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Repositories"),
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<RepositriesProvider>(
        builder: (_, value, __) {
          return value.getUserRepoData == null
              ? Center(child: CupertinoActivityIndicator())
              : ListView.builder(
                 // shrinkWrap: true,
                  itemCount: value.getUserRepoData?.length,
                //  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int position) {
                    var item = value.getUserRepoData![position];
                    return GestureDetector(
                      onTap: () {
                        _launchURL(item.url);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.repo_name,
                                    style: textStyle
                                  ),
                                 Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ],
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:  EdgeInsets.only(right: width * 0.02),
                              child: Text(
                                "${f.format(DateTime.parse((item.created_date.toString())))}",
                                style: textStyle.copyWith(fontSize: width * 0.028),
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }

  void fetchUser() {
    Provider.of<RepositriesProvider>(context, listen: false)
        .sentRequestGetUserRepo(context, _scaffoldKey, widget.uName!);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
