import 'package:flutter/material.dart';
import 'report2.dart';
import 'self2.dart';


class self1 extends StatefulWidget {
  self1({Key key, @required var list}): super(key:key){
    this.list = list;
  }

  @override
  _self1 createState() => new _self1(list: list);
  var list;
}

class _self1 extends State<self1> {
  _self1({@required var list}){
    this.list = list;
    print(list);
  }
  var list;


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
            Navigator.push(context, MaterialPageRoute(builder: (context) => self2(id: map,)));
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
                            Text(map['date']==null?'null':map['date'],style: new TextStyle(fontSize: 18,),),
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
            '病症自拍',
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