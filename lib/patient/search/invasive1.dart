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


class invasive1 extends StatefulWidget {
  invasive1({Key key, @required var list}): super(key:key){
    this.list = list;
  }

  @override
  _invasive1 createState() => new _invasive1(list: list);
  var list;
}

class _invasive1 extends State<invasive1> {
  _invasive1({@required var list}){
    this.list = list;
    log(list.toString());
  }
  var list;

  Map labelmap = {
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

            List urls = new List();

            for (String value in map['address']) {
              urls.add('http://' +
                  value.toString());
            }

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PictureView(
                          urls: urls,
                        )));

//            var bodymap = Map();
//            Map report = Map();
//            report['id'] = map['id'];
//            bodymap['report'] = report;
//            var url = "http://39.100.100.198:8082/watchPatientSomeInfo";
//            var formData = bodymap;
//            await request(url, context, FormData: formData).then((value) {
//              var data = json.decode(value.toString());
//              log(data.toString());
//              Navigator.push(context, MaterialPageRoute(builder: (context) => medicalReport(id: data['reports'][0],)));
//
//            });

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
                            Text('无',style: new TextStyle(fontSize: 18,),),
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
            '',
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