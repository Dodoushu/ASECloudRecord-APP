import 'package:flutter/material.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'package:helloworld/http_service.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:helloworld/patient/search/outPatients.dart';
import 'package:helloworld/patient/search/examine.dart';
import 'package:helloworld/patient/search/admission.dart';
import 'package:helloworld/patient/search/outPatientsRecords.dart';
import 'report2.dart';
import 'package:helloworld/patient/pictureGridview.dart';
import 'laboratory2.dart';


class laboratory1 extends StatefulWidget {
  laboratory1({Key key, @required var list}): super(key:key){
    this.list = list;
  }

  @override
  _laboratory1 createState() => new _laboratory1(list: list);
  var list;
}

class _laboratory1 extends State<laboratory1> {
  _laboratory1({@required var list}){
    this.list = list;
    log(list.toString());
  }
  var list;

  Map labelmap = {
    '0': '无类目',
    '1': '血液检查',
    '2': '尿液检查',
    '3': '粪便检查',
    '4': '精液检查',
    '5': '胸水检查',
    '6': '腹水检查',
    '7': '脑脊液检查',
    '8': '其他化验检查',
  };

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    List buildList(var list){
      print(list);
      List<Widget> buildedList = new List();
      for(Map map in list){
        Widget itemCard = InkWell(
          onTap: ()async{

            print(map);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        laboratory2(
                          id: map,
                        )));
          },
          child: new Container(
            padding: EdgeInsets.only(left: 10,right: 10),
            //宽度
            width: width_*0.95,
            // 盒子样式
            decoration: new BoxDecoration(
              //设置Border属性给容器添加边框
              border: new Border.all(
                //为边框添加颜色
                color: Colors.black12,
                width: 0.1, //边框宽度
              ),
            ),
            child: new Card(
              margin: EdgeInsets.only(top: 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  new Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10,left: 20),
                    //宽度
                    width: width_*0.7,
                    child: new Column(
                      children: [
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('日期',style: new TextStyle(fontSize: 18,),),
                            Text(map['date']==null?'无':map['date'],style: new TextStyle(fontSize: 18,),),

                          ],
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('类目',style: new TextStyle(fontSize: 18,),),
//                            Text('无',style: new TextStyle(fontSize: 18,),),
                            Text(labelmap[map['items'].toString()],style: new TextStyle(fontSize: 18,),)
                          ],
                        ),

                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 30,)
                ],
              ),
            ),
          ),
        );
        buildedList.add(itemCard);
      }
      return buildedList;
    }

    return Scaffold(
        appBar: new AppBar(
          title: Text(
            '化验检查',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: buildList(list),
        )
    );
  }
}