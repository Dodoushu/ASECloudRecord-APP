import 'package:flutter/material.dart';
import 'package:helloworld/patient/MainFunctionPage.dart';
import 'BottomNavigationBar.dart';
import 'setting/ChangePassword.dart';
import 'setting/ChangePhoneNumber.dart';
import 'setting/doctorSelect.dart';

void main() {
  runApp(new MaterialApp(
    title: '设置页',
    home: new Setting(),
  ));
}

List<Widget> buildCheckboxListTile() {
  var doctorlist = [
    {'id': 1, 'name': '张一', 'info': '其他信息'},
    {'id': 2, 'name': '张二', 'info': '其他信息'},
    {'id': 3, 'name': '张三', 'info': '其他信息'},
    {'id': 4, 'name': '张四', 'info': '其他信息'},
    {'id': 5, 'name': '张五', 'info': '其他信息'},
    {'id': 6, 'name': '张六', 'info': '其他信息'},
    {'id': 7, 'name': '张七', 'info': '其他信息'}
  ];
  List<bool> valueList = [];
  valueList.add(false);
  for (Map obj in doctorlist){
    valueList.add(false);
  }
  var CheckoxListTitleList = List<CheckboxListTile>();
  CheckoxListTitleList.add(CheckboxListTile(
    secondary: const Icon(Icons.accessible_forward),
    title: Text('所有医生'),
    value: true,
    onChanged: (bool value) {
      print(value);
    },
  ));
  for (Map obj in doctorlist) {
    CheckoxListTitleList.add(new CheckboxListTile(
      secondary: const Icon(Icons.accessible_forward),
      title: Text(obj['name']),
      subtitle: Text(obj['info']),
      value: true,
      onChanged: (bool value) {
        print(value);
      },
    ));
  }
  return CheckoxListTitleList;
}

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => new _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    Widget ChangePspt = new Container(
        padding: EdgeInsets.only(top: 30, left: 10, right: 5),
        child: SizedBox(
            height: 60,
            width: 390,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePhNum()));
              },
              child: new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 0.5)),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '修改手机号',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
//                  padding: EdgeInsets.only(left: 230),
                              child: new Icon(
                                Icons.arrow_forward_ios,
                                size: 26,
                              ),
                            ),
                          ]))),
            )));
    Widget ChangePhonenum = new Container(
        padding: EdgeInsets.only(top: 0, left: 10, right: 5),
        child: SizedBox(
            height: 60,
            width: 400,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChangePswd()));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 0.5)),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '修改密码',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
//                      padding: EdgeInsets.only(left: 250),
                              child: new Icon(
                                Icons.arrow_forward_ios,
                                size: 26,
                              ),
                            ),
                          ]))),
            )));

    Widget ensure = new Container(
      height: 60.0,
      width: 10,
      margin: EdgeInsets.only(top: 10, left: 40, right: 40),
      child: new RaisedButton(
        color: Colors.blue,
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(25.0)),
        child: new Text(
          '确定',
          style: TextStyle(fontSize: 23.0, color: Colors.white),
        ),
      ),
    );

//    Widget ChangeDoctor = new Container(
//        padding: EdgeInsets.only(left: 10, right: 5),
//        child: SizedBox(
//            height: 60,
//            width: 390,
//            child: InkWell(
//              onTap: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => ChangePhNum()));
//              },
//              child: new Card(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                      side: BorderSide(width: 0.5)),
//                  child: Container(
//                      padding: EdgeInsets.only(left: 10,right: 10),
//                      child:Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Container(
//                          alignment: Alignment.centerLeft,
//                          padding: EdgeInsets.only(left: 10),
//                          child: Text(
//                            '修改医生权限',
//                            style: TextStyle(fontSize: 18),
//                          ),
//                        ),
//                        Container(
////                          padding: EdgeInsets.only(left: 230),
//                          child: new Icon(
//                            Icons.arrow_forward_ios,
//                            size: 26,
//                          ),
//                        ),
//                      ]))),
//            )));

    Widget ChangeDoctor = new Container(
        padding: EdgeInsets.only(top: 0, left: 10, right: 5),
        child: SizedBox(
            height: 60,
            width: 400,
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => doctorSelect()));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      side: BorderSide(width: 0.5)),
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                '修改医生权限',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
//                      padding: EdgeInsets.only(left: 250),
                              child: new Icon(
                                Icons.arrow_forward_ios,
                                size: 26,
                              ),
                            ),
                          ]))),
            )));

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          '设置',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
//        backgroundColor: Colors.blue,
//        leading: new Icon(Icons.arrow_back_ios,size: 25,),
      ),
      body: new ListView(
        children: <Widget>[ChangePspt, ChangePhonenum, ChangeDoctor],
      ),
    );
  }
}
