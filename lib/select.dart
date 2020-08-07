import 'package:flutter/material.dart';
import 'package:helloworld/showAlertDialogClass.dart';
import 'patient/login.dart';

void main() => runApp(MaterialApp(
      home: select(),
    ));

class select extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget doctorCard = SizedBox(
      height: 210,
      width: 350,
      child: InkWell(
        onTap: () {
          print('我是医生');
          showAlertDialog(context,
              titleText: '医生端功能尚未开放', contentText: '请点击确定返回');
        },
        child: Card(
          elevation: 15.0, //阴影
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
              side: BorderSide(width: 1.0)),
          //设置圆角和边框
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/doctor.png',
                width: 120,
              ),
              Text(
                ' 我是医生',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
    Widget peopleCard = SizedBox(
      height: 210,
      width: 350,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Card(
          elevation: 15.0, //阴影
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28.0)),
              side: BorderSide(width: 1.0)),
          //设置圆角和边框
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/record.png',
                width: 120,
              ),
              Text(
                ' 我是患者',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[doctorCard, peopleCard],
      ),
    ));
  }
}
