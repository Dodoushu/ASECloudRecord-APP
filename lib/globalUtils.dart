import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:photo_view/photo_view.dart';
import 'package:city_pickers/city_pickers.dart';

Widget smallPicGridView(List list) {
  List piclist = list;
  if (piclist.length > 0) {
    return new GridView.builder(
      shrinkWrap: true, //解决 listview 嵌套报错
      physics: NeverScrollableScrollPhysics(), //禁用滑动事件
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //每行三列
          mainAxisSpacing: 4, //
          crossAxisSpacing: 8, //缩略图间距
          childAspectRatio: 1.0 //显示区域宽高相等
          ),
      itemCount: piclist.length,
      itemBuilder: (context, index) {
        return new GestureDetector(
          child: Container(
            child: new Image(
              image: FileImage(File(piclist[index])),
              fit: BoxFit.cover,
            ), //这句可以完成中心裁剪
          ),
          onTap: () {
//                        Navigator.push(context, MaterialPageRoute(builder: (context) => BigPhoto(url: urls[index],)));
          },
        );
      },
    );
  } else {
    return Text(
      '未选择文件',
      style: TextStyle(fontSize: 16),
    );
  }
}

Widget onePicWidget(String filePath, double width) {
  String Path = filePath;
  if (Path != null) {
    Widget widget = new Center(
        child: Container(
      width: width,
      child: new Image(
        image: FileImage(File(Path)),
        fit: BoxFit.cover,
      ),
    ) //这句可以完成中心裁剪,
        );

//    Container(child: new Image(image: FileImage(File(piclist[index])), fit: BoxFit.cover,), //这句可以完成中心裁剪
    return widget;
  } else {
    return Text(
      '未选择文件',
      style: TextStyle(fontSize: 16),
    );
  }
}

Widget smallPicGridViewNet(List list) {
  List piclist = list;
  if (piclist.length > 0) {
    return new GridView.builder(
      shrinkWrap: true, //解决 listview 嵌套报错
      physics: NeverScrollableScrollPhysics(), //禁用滑动事件
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //每行三列
          mainAxisSpacing: 4, //
          crossAxisSpacing: 8, //缩略图间距
          childAspectRatio: 1.0 //显示区域宽高相等
          ),
      itemCount: piclist.length,
      itemBuilder: (context, index) {
        return new GestureDetector(
          child: Container(
            child: new Image.network(
              'http://' + piclist[index],
              fit: BoxFit.cover,
            ), //这句可以完成中心裁剪
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BigPhotoNet(
                          url: 'http://' + piclist[index],
                        )));
          },
        );
      },
    );
  } else {
    return Text(
      '无图片',
      style: TextStyle(fontSize: 16),
    );
  }
}

class BigPhotoNet extends StatelessWidget {
  final String url;
  BigPhotoNet({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new GestureDetector(
        child: Container(
          child: PhotoView(
            imageProvider: new NetworkImage(url),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

Map cityPickerResultToMap(Result result) {
  Map map = new Map();
  map['provinceName'] = result.provinceName;
  map['provinceId'] = result.provinceId;
  map['cityName'] = result.cityName;
  map['cityId'] = result.cityId;
  map['areaName'] = result.areaName;
  map['areaId'] = result.areaId;
  return map;
}

Result mapToCityPickerResult(Map map) {
  Result result = new Result(
      provinceId: map['provinceId'],
      provinceName: map['provinceName'],
      cityId: map['cityId'],
      cityName: map['cityName'],
      areaId: map['cityId'],
      areaName: map['areaName']);
  return result;
}
