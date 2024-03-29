import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/File_Method.dart';
import 'package:helloworld/PickFileMethod.dart';
import 'package:helloworld/http_service.dart';
import 'package:helloworld/sharedPrefrences.dart';
import 'MainFunctionPage.dart';
import 'package:helloworld/globalUtils.dart';
import 'package:helloworld/login.dart';
import 'package:helloworld/showAlertDialogClass.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: register2());
  }
}

class register2 extends StatefulWidget {
  @override
  _register2 createState() => new _register2();
}

class _register2 extends State<register2> {


  String name;         //姓名
  String id_number;    //身份证号
  String specialty;
  String introduction;
  String socialwork;
  String hospital;
  String Hospitalclass;

  MultipartFile id_photo;
  MultipartFile id_card1;
  MultipartFile id_card2;
  MultipartFile certificate;
  MultipartFile worklicense;
  MultipartFile title_certi;

  File_Method file_method = new File_Method();

  var map = Map();
  var filename = Map();

  //上传表单
  void submit() {
    if(name != null && id_number != null && specialty!= null && introduction!= null && socialwork!= null && hospital!= null
         && Hospitalclass!= null && map['id_photo'] != null && map['id_card1'] != null && map['id_card2'] != null
         && map['certificate'] != null && map['worklicense'] != null && map['title_certi'] != null){
      var doctor= Map<String,dynamic>();
      String phoneNum;
      SharedPreferenceUtil.getString('userId').then((value){

        var url = 'http://39.100.100.198:8082/DoctorInfo';
        doctor['userId'] = value;
        doctor['name'] = name;
        doctor['id_num'] = id_number;
        doctor['specialty'] = specialty;
        doctor['personal_info'] = introduction;
        doctor['social_work'] = socialwork;
        doctor['hospital'] = hospital;
        doctor['department'] = Hospitalclass;

        List<MultipartFile> fileList = List();
        fileList.add(map['id_photo']);
        fileList.add(map['id_card1']);
        fileList.add(map['id_card2']);
        fileList.add(map['certificate']);
        fileList.add(map['worklicense']);
        fileList.add(map['title_certi']);
        doctor['files'] = fileList;

        List<int> types = new List();
        types.add(1);
        types.add(2);
        types.add(3);
        types.add(4);
        types.add(5);
        types.add(6);
        doctor['types'] = "1,2,3,4,5,6";

        print(doctor.toString());

        FormData formData = FormData.fromMap(doctor);

        request(url,context, FormData: formData, contentType: 'multipart/form-data').then((value) {
          Map data = json.decode(value.toString());
          print(data.toString());
          if(data['status_code'] == 1){
            SharedPreferenceUtil.setString('userId', data['userId'].toString()).then((value){
              SharedPreferenceUtil.setString('name', data['name']).then((value){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
              });
            });
          }
        });
      });
    }else {
      showAlertDialog(context, titleText: '', contentText: '信息不全', flag: 0);
    }
  }

  void _selectFile(String imageflag) async {
    getSingleImagePath().then((path) {
      MultipartFile.fromFile(path).then((value) {
        map[imageflag] = value;
      });

      setState(() {
        filename[imageflag] = path.toString();
      });
    });
  }

  void _selectFilefromCamera(String imageflag) async {
    getImageFileFromCamera().then((path) {
      MultipartFile.fromFile(path).then((value) {
        map[imageflag] = value;
      });
      setState(() {
        filename[imageflag] = path.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    double width_ = MediaQuery.of(context).size.width;

    Widget BasicInfo = new Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '基础信息',
                style: TextStyle(fontSize: 25),
              ),
              Divider(
                thickness: 2,
              ),
              TextField(
                decoration: new InputDecoration(
                  labelText: '请输入您的姓名',
                  labelStyle: new TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 93, 93, 93)),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              Divider(
                thickness: 2,
              ),
              TextField(
                decoration: new InputDecoration(
                    labelText: '请输入您的身份证号',
                    labelStyle: new TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none),
                onChanged: (value) {
                  id_number = value;
                },
              ),
              Divider(
                thickness: 2,
              ),

              TextField(
                decoration: new InputDecoration(
                    labelText: '请输入医院名称',
                    labelStyle: new TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none),
                onChanged: (value) {
                  hospital = value;
                },
              ),
              Divider(
                thickness: 2,
              ),

              TextField(
                decoration: new InputDecoration(
                    labelText: '请输入科室名称',
                    labelStyle: new TextStyle(
                        fontSize: 15, color: Color.fromARGB(255, 93, 93, 93)),
                    border: InputBorder.none),
                onChanged: (value) {
                  Hospitalclass = value;
                },
              ),
              Divider(
                thickness: 2,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '证件照:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Row(
                    children: [new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () => {_selectFile('id_photo')},
                          color: Colors.blue,
                          child: new Text('选择照片',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )),
                      new Container(
                          margin: EdgeInsets.only(left: 5),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () => {_selectFilefromCamera('id_photo')},
                            color: Colors.blue,
                            child: new Text('相机拍照',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0)),
                          )),],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Center(child: onePicWidget(filename['id_photo'], width_*0.6)),
//              new Text(
//                filename['id_photo'].toString(),
//                //"dasda",
//                style: TextStyle(fontSize: 19),
//              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '身份证正面照片:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Row(
                    children: [new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () => {_selectFile('id_card1')},
                          color: Colors.blue,
                          child: new Text('选择照片',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )),
                      new Container(
                          margin: EdgeInsets.only(left: 5),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () => {_selectFilefromCamera('id_card1')},
                            color: Colors.blue,
                            child: new Text('相机拍照',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0)),
                          ))],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Center(child: onePicWidget(filename['id_card1'], width_*0.6)),
//              new Text(
//                filename['id_card1'].toString(),
//                //"dasda",
//                style: TextStyle(fontSize: 19),
//              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '身份证反面照片:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Row(
                    children: [new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () => {_selectFile('id_card2')},
                          color: Colors.blue,
                          child: new Text('选择照片',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )),
                      new Container(
                          margin: EdgeInsets.only(left: 5),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () => {_selectFilefromCamera('id_card2')},
                            color: Colors.blue,
                            child: new Text('相机拍照',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0)),
                          ))],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Center(child: onePicWidget(filename['id_card2'], width_*0.6)),
//              new Text(
//                filename['id_card2'].toString(),
//                //"dasda",
//                style: TextStyle(fontSize: 19),
//              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '医师资格证:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Row(
                    children: [new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () => {_selectFile('certificate')},
                          color: Colors.blue,
                          child: new Text('选择照片',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )),
                      new Container(
                          margin: EdgeInsets.only(left: 5),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () => {_selectFilefromCamera('certificate')},
                            color: Colors.blue,
                            child: new Text('相机拍照',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0)),
                          ))],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Center(child: onePicWidget(filename['certificate'], width_*0.6)),

//              new Text(
//                filename['certificate'].toString(),
//                //"dasda",
//                style: TextStyle(fontSize: 19),
//              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '医师执业证:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Row(
                    children: [new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () => {_selectFile('worklicense')},
                          color: Colors.blue,
                          child: new Text('选择照片',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )),
                      new Container(
                          margin: EdgeInsets.only(left: 5),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () =>
                            {_selectFilefromCamera('worklicense')},
                            color: Colors.blue,
                            child: new Text('相机拍照',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0)),
                          ))],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Center(child: onePicWidget(filename['worklicense'], width_*0.6)),
//              new Text(
//                filename['worklicense'].toString(),
//                //"dasda",
//                style: TextStyle(fontSize: 19),
//              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '医师职称证书:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    ),
                  ),
                  new Row(
                    children: [new Container(
                        margin: EdgeInsets.only(left: 10),
                        child: RaisedButton(
                          elevation: 0,
                          onPressed: () => {_selectFile('title_certi')},
                          color: Colors.blue,
                          child: new Text('选择照片',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              )),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0)),
                        )),
                      new Container(
                          margin: EdgeInsets.only(left: 10),
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () => {_selectFilefromCamera('title_certi')},
                            color: Colors.blue,
                            child: new Text('相机拍照',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0)),
                          ))],
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '已选择文件:',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              new Center(child: onePicWidget(filename['title_certi'], width_*0.6)),
//              new Text(
//                filename['title_certi'].toString(),
//                //"dasda",
//                style: TextStyle(fontSize: 19),
//              ),
              new SizedBox(height: 15,),
              Divider(
                thickness: 2,
              ),
              Container(
                child: Text('专业特长:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    )),
              ),
              TextField(
                decoration: new InputDecoration(
                  labelStyle: new TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),
                  ),
                  //border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                onChanged:(value){
                  specialty = value;
              } ,
              ),
              Container(
                child: Text('医师简介:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    )),
              ),
              TextField(
                decoration: new InputDecoration(
                  labelStyle: new TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),
                  ),
                  //border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                onChanged: (value){
                  introduction = value;
                },
              ),
              Container(
                child: Text('社会兼职:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 93, 93, 93),
                    )),
              ),
              TextField(
                decoration: new InputDecoration(
                  labelStyle: new TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 93, 93, 93),
                  ),
                  //border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                onChanged: (value){
                  socialwork = value;
                },
              )
            ],
          ),
        ));

    Widget ok = new Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 0.0, bottom: 30, left: 30, right: 30),
      child: new SizedBox.expand(
        child: new RaisedButton(
            elevation: 0,
            color: Colors.blue,
            child: new Text(
              '确定',
              style: TextStyle(
                  fontSize: 20.0, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(40.0)),
            onPressed: submit
        ),
      ),
    );
    return new MaterialApp(
      title: '医生注册2',
      home: new Scaffold(
        appBar: new AppBar(
            title: Text(
              '信息录入',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: new Icon(
              Icons.arrow_back_ios,
              size: 25,
            )),
        body: new ListView(
          children: <Widget>[BasicInfo, ok],
        ),
      ),
    );
  }
}

//缩略图Widget
Widget imgItem(index, setState, imgData) {
  return GestureDetector(
    child: Container(
      color: Colors.transparent,
      child: Stack(alignment: Alignment.topRight, children: <Widget>[
        ConstrainedBox(
          child: Image.file(imgData[index], fit: BoxFit.cover),
//          child: Image.file(File(imgData[index]), fit: BoxFit.cover),
          constraints: BoxConstraints.expand(),
        ),
      ]),
    ),
  );
}
