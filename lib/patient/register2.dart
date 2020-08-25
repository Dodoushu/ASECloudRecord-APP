import 'package:flutter/material.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'dart:convert';
import 'MainFunctionPage.dart';
import 'package:helloworld/showAlertDialogClass.dart';

void main() => runApp(MaterialApp(home: register2(),));

class register2 extends StatefulWidget {
  @override
  State createState() => new _register2();
}

class _register2 extends State<register2> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String name;
  String sex;
  String nation;
  String birthplace;
  String ID;

  int formerResidenceNumber;
  int ICENumber;

  String mailAddress;
  String address;

  String FR1;
  String FR2;
  String ICE1name;
  String ICE1phone;
  String ICE2name;
  String ICE2phone;

  String lebalContent = '请选择性别';
  Map labelmap = {
    '0':'男',
    '1':'女',
  };


  List<DropdownMenuItem> getListData(){
    List<DropdownMenuItem> items=new List();
    DropdownMenuItem dropdownMenuItem1=new DropdownMenuItem(
      child:new Text('男'),
      value: '0',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2=new DropdownMenuItem(
      child:new Text('女'),
      value: '1',
    );
    items.add(dropdownMenuItem2);
    return items;
  }

//  void frplus() {
//    if (formerResidenceNumber == null) {
//      formerResidenceNumber = 1;
//    }
//    if (formerResidenceNumber <= 3) {
//      setState(() {
//        formerResidenceNumber++;
//      });
//    }
//  }
//
//  void INplus() {
//    if (ICENumber == null) {
//      ICENumber = 1;
//    }
//    if (ICENumber <= 3) {
//      setState(() {
//        ICENumber++;
//      });
//    }
//  }

  void summit() async{
//    print(name);
//    var loginForm = loginKey.currentState;
//    //验证Form表单
//    if(loginForm.validate()){
//      print(name);
//    }
    var bodymap = Map();
    var patient = Map();
    String phoneNum;
    SharedPreferenceUtil.getString('phoneNum').then((value){
      phoneNum = value;
      bodymap['phone_num']=phoneNum;
      patient['name']=name;
      SharedPreferenceUtil.setString("name", name).then((value) async{
        patient['sex']=int.parse(sex);
        patient['race']=nation;
        patient['birthplace']=birthplace;
        patient['id_num']=ID;
        patient['postal_addr']=mailAddress;
        patient['now_addr']=address;
        patient['pre_addr1']=FR1;
        patient['emerge']=[{'name':ICE1name,'phone_num':ICE1phone},{'name':ICE2name,'phone_num':ICE2phone}];
        bodymap['patient']=patient;
        print(bodymap);
        var url = "http://39.100.100.198:8082/patient";
        var formData = bodymap;
        await request(url,FormData: formData).then((value) {
          var data = json.decode(value.toString());
          if(data['status_code']==1){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage()), (route) => false);
          }else if(data['status_code']==0){
            showAlertDialog(context,titleText: 'failed',contentText: '身份信息证已存在，请重试');
          }else if(data['status_code']==2){
            showAlertDialog(context,titleText: 'failed',contentText: '必填信息不全，请重试');
        }});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget basicInfo = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '基础信息',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Column(
              children: <Widget>[
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的姓名',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '性别:',
                      style: TextStyle(fontSize: 19),
                    ),
                    new DropdownButton(
                      items: getListData(),
                      hint:new Text(lebalContent),//当没有默认值的时候可以设置的提示
                      onChanged: (value){//下拉菜单item点击之后的回调
                        sex = value;
                        print(sex);
                        setState(() {
                          lebalContent = labelmap[value];
                        });
                      },
                      elevation: 24,//设置阴影的高度
                      style: new TextStyle(//设置文本框里面文字的样式
                          color: Colors.black,
                          fontSize: 15
                      ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                      iconSize: 50.0,//设置三角标icon的大小
                    ),
                  ],
                ),

                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的民族',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    nation = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的出生地',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    birthplace = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的身份证号',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    ID = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            )
          ],
        ),
      ),
    );

    Widget dividerline = Container(
      height: 30,
    );

    Widget contact = Container(
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '联络方式',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            Divider(
              thickness: 2,
            ),
            Column(
              children: <Widget>[
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的通讯地址',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    mailAddress = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的现居住地',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    address = value;
                  },
                ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '曾居住地',
                        style: TextStyle(fontSize: 18),
                      ),
//                      IconButton(
//                        icon: Icon(Icons.add),
//                        onPressed: frplus,
//                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                ),
                TextField(
                  decoration: new InputDecoration(
                    labelText: '请输入您的曾居住地1',
                    labelStyle: new TextStyle(
                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  onChanged: (value) {
                    FR1 = value;
                  },
                ),
//                Divider(
//                  thickness: 2,
//                ),
//                TextField(
//                  decoration: new InputDecoration(
//                    labelText: '请输入您的曾居住地2',
//                    labelStyle: new TextStyle(
//                        fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
//                    border: InputBorder.none,
//                  ),
//                  maxLines: 5,
//                  onChanged: (value) {
//                    FR2 = value;
//                  },
//                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '紧急联系人',
                      style: TextStyle(fontSize: 18),
                    ),
//                    IconButton(
//                      icon: Icon(Icons.add),
//                      onPressed: frplus,
//                    )
                  ],
                )),
            Divider(
              thickness: 2,
            ),
            TextField(
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人1姓名',
                labelStyle: new TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ICE1name = value;
              },
            ),
            Divider(
              thickness: 2,
            ),
            TextField(
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人1电话',
                labelStyle: new TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ICE1phone = value;
              },
            ),
            Divider(
              thickness: 2,
            ),
            TextField(
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人2姓名',
                labelStyle: new TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ICE2name = value;
              },
            ),
            Divider(
              thickness: 2,
            ),
            TextField(
              decoration: new InputDecoration(
                labelText: '请输入您的紧急联系人2电话',
                labelStyle: new TextStyle(
                    fontSize: 15.0, color: Color.fromARGB(255, 93, 93, 93)),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                ICE2phone = value;
              },
            ),
          ],
        ),
      ),
    );

    Widget ok = new Container(
//      padding: EdgeInsets.only(left: 10,right: 10,bottom: 0),
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
          elevation: 0,
          onPressed: summit,
          color: Colors.blue,
          child: new Text(
            '确定',
            style: TextStyle(
                fontSize: 14.0, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0)),
        ),
      ),
    );

    return Scaffold(
          appBar: AppBar(
            title: Text(
              '用户注册',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
//            backgroundColor: Colors.white,
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
                  '基础信息填写',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
//              padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[basicInfo, dividerline, contact, ok],
                ),
              )
            ],
          ));

  }
}
