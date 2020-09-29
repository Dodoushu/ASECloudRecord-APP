import 'package:flutter/material.dart';
import 'package:helloworld/patient/MainFunctionPage.dart';
import 'package:helloworld/select.dart';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';


class examine extends StatefulWidget {
  examine({Key key, @required this.contentlist}) : super(key: key) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  _examineState createState() =>
      new _examineState(contentlist: contentlist);
}

class _examineState extends State<examine> {
  _examineState({@required List contentlist}) {
    this.contentlist = contentlist;
  }

  List contentlist;

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;

    List<Widget> contentCardBuilder() {
      List<Widget> returnList = new List<Widget>();
      for (Map temp in contentlist) {
        Widget contentCard = Container(
          padding: EdgeInsets.only(
            top: 7, bottom: 3
          ),
            child: new Card(
              margin: EdgeInsets.only(
                right: width_ * 0.03,
                left: width_ * 0.03,

              ),
              child: Container(
                  margin: EdgeInsets.only(
                    right: width_ * 0.03,
                    left: width_ * 0.03,
                      top: 15,
                      bottom: 15
                  ),
                  child: Column(
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '检查内容：',
                            style: new TextStyle(fontSize: 18),
                          ),
                          Text(
                            temp['examine_info'],
                            style: new TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  )),
            ));
        returnList.add(contentCard);
      }
      return returnList;
    }

//    Widget contentCard = new Container(
//      width: width_*0.95,
//      child: new Column(
//        children: contentCardBuilder(),
//      ),
//    );

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          '病理学检查查询',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: contentCardBuilder(),
      ),
    );
  }
}