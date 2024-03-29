import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/PickFileMethod.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'package:helloworld/showAlertDialogClass.dart';
import 'package:intl/intl.dart';

import 'package:helloworld/globalUtils.dart';


class laboratory2 extends StatefulWidget {
  laboratory2({Key key, @required var id}): super(key:key){
    this.id = id;
  }
  var id;

  @override
  State createState() => new _laboratory2(id: id);
}

class _laboratory2 extends State<laboratory2> {

  _laboratory2({@required var id}){
    this.id = id;
    print(id);
  }
  var id;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    
  List<Widget> buildList(){

    List<Widget> returnlist = new List();

    Widget basicInfo = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '化验日期:',
                    style: TextStyle(fontSize: 19),
                  ),
                  Text(
                    id['date'],
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Column(
              children: <Widget>[
                new Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('化验结论',style: TextStyle(fontSize: 19),),
                        Container(),
                      ],
                    ),
                    Container(width: 10,),
                    new Text(id['result'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 19,
                          letterSpacing: 1,
                          wordSpacing: 2,
                          height: 1.2,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '附带图片:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                smallPicGridViewNet(id['address'])
              ],
            )
          ],
        ),
      ),
    );

    returnlist.add(basicInfo);
    return returnlist;

  }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //修改颜色
          ),
          title: Text(
            '化验检查',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
//          backgroundColor: Colors.white,

        ),
        body: ListView(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              width: double.infinity,
              height: 90,
              child: Center(
                  child: new Text(
                    '化验检查查询',
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
//              padding: EdgeInsets.only(top: 30),
              child: Column(
                children: buildList(),
              ),
            )
          ],
        ));
  }
}
