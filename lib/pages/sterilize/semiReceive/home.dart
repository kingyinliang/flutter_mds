import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/components/raisedButton.dart';
import 'package:dfmdsapp/utils/pxunit.dart' show pxUnit;
import 'package:dfmdsapp/utils/toast.dart';
import 'package:dfmdsapp/components/slide_button.dart';
import 'package:dfmdsapp/api/api/index.dart';

import '../common/page_head.dart';
import '../common/item_card.dart';
import '../common/remove_btn.dart';

class SemiReceivePage extends StatefulWidget {
  final arguments;
  SemiReceivePage({Key key, this.arguments}) : super(key: key);

  @override
  _SemiReceivePageState createState() => _SemiReceivePageState();
}

class _SemiReceivePageState extends State<SemiReceivePage>
    with TickerProviderStateMixin {
  AnimationController _ctrlAnimationCircle;
  List wrapList = [
    {'label': '', 'value': 'fermentPotNo'},
    {'label': '', 'value': 'materialName'},
    {'label': '', 'value': 'consumeBatch'},
    {'label': '发酵罐库存', 'value': 'fermentStorage'},
    {'label': '', 'value': 'tankNo'},
    {'label': '', 'value': 'changer'},
    {'label': '', 'value': 'changed'},
    {'label': '备注：', 'value': 'remark'},
  ];

  List semiList = [];

  getListCard() {
    List listWidget = [];
    listWidget = semiList.asMap().keys.map((index) {
      return SlideButton(
        index: index,
        singleButtonWidth: 70,
        child: ItemCard(
          carTitle: '半成品领用领用数量',
          cardMap: semiList[index],
          title: 'consumeAmount',
          subTitle: 'consumeUnit',
          wrapList: wrapList,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/sterilize/semiReceive/add',
              arguments: {
                'orderNo': widget.arguments['potNum']['orderNo'],
                'stePotNo': widget.arguments['potNum']['pot'],
                'potOrderNo': widget.arguments['potNum']['potNo'],
                'potOrderId': widget.arguments['potNum']['potOrderId'],
                'data': semiList[index],
              },
            ).then((value) => value != null ? _initState() : null);
          },
        ),
        buttons: <Widget>[
          CardRemoveBtn(
            removeOnTab: () => _semiDel(index),
          ),
        ],
      );
    }).toList();
    return listWidget;
  }

  _semiSubmit() async {
    try {
      await Sterilize.semiSubmitApi({
        'potOrderNo': widget.arguments['potNum']['potNo'],
        'type': '',
      });
      successToast(msg: '操作成功');
      setState(() {});
    } catch (e) {}
  }

  _semiDel(index) async {
    try {
      await Sterilize.semiDelApi({
        'ids': [semiList[index]['id']],
        'potOrderNo': widget.arguments['potNum']['potNo'],
      });
      successToast(msg: '操作成功');
      semiList.removeAt(index);
      setState(() {});
    } catch (e) {}
  }

  _initState() async {
    try {
      var res = await Sterilize.semiHomeApi({
        "orderNo": widget.arguments['potNum']['orderNo'],
        "potOrderNo": widget.arguments['potNum']['potNo']
      });
      semiList = res['data'];
      setState(() {});
    } catch (e) {}
  }

  _copyBtnClick() async {
    try {
      await Sterilize.semiCopyApi({
        "orderNo": widget.arguments['potNum']['orderNo'],
        "potOrderNo": widget.arguments['potNum']['potNo']
      });
      successToast(msg: '操作成功');
      _initState();
    } catch (e) {}
  }

  _addBtnClick() {
    Navigator.pushNamed(
      context,
      '/sterilize/semiReceive/add',
      arguments: {
        'orderNo': widget.arguments['potNum']['orderNo'],
        'stePotNo': widget.arguments['pot'],
        'potOrderNo': widget.arguments['potNum']['potNo'],
        'potOrderId': widget.arguments['potNum']['potOrderId'],
      },
    ).then((value) => value != null ? _initState() : null);
  }

  @override
  void initState() {
    _ctrlAnimationCircle = AnimationController(
        lowerBound: 0,
        upperBound: 50,
        duration: Duration(milliseconds: 300),
        vsync: this);
    _ctrlAnimationCircle.addListener(() => setState(() {}));
    Future.delayed(
      Duration.zero,
      () => setState(() {
        _initState();
      }),
    );
    super.initState();
  }

  @override
  void dispose() {
    _ctrlAnimationCircle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MdsAppBarWidget(titleData: '半成品领用'),
      backgroundColor: Color(0xFFF5F5F5),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(height: 5),
              PageHead(
                title:
                    '${widget.arguments['potName']} 第${widget.arguments['potNum']['potOrder']}锅',
                subTitle: '${widget.arguments['potNum']['materialName']}',
                orderNo: '${widget.arguments['potNum']['orderNo']}',
                potNo: '${widget.arguments['potNum']['potNo']}',
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.fromLTRB(12, 10, 0, 60),
                child: Column(
                  children: getListCard(),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 70 + _ctrlAnimationCircle.value * sin(0 * pi / 3),
            right: 5 + _ctrlAnimationCircle.value * cos(0 * pi / 3),
            child: RawMaterialButton(
              fillColor: Color(0xFF1677FF),
              splashColor: Colors.amber[100],
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              shape: CircleBorder(),
              onPressed: _addBtnClick,
            ),
          ),
          Positioned(
            bottom: 70 + _ctrlAnimationCircle.value * sin(1 * pi / 3),
            right: 5 + _ctrlAnimationCircle.value * cos(1 * pi / 3),
            child: RawMaterialButton(
              shape: CircleBorder(),
              splashColor: Colors.amber[100],
              fillColor: Color(0xFF1677FF),
              child: Icon(
                Icons.content_copy,
                color: Colors.white,
                size: 17,
              ),
              onPressed: _copyBtnClick,
            ),
          ),
          Positioned(
            bottom: 68,
            right: 7,
            child: RawMaterialButton(
              fillColor: Color(0xFF1677FF),
              splashColor: Color(0xFF1677FF),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Transform(
                  transform: Matrix4.identity()
                    ..rotateZ(_ctrlAnimationCircle.value / 50 * pi / 2 * 1.5),
                  origin: Offset(17, 17),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
              ),
              shape: CircleBorder(),
              onPressed: () {
                setState(() {
                  _ctrlAnimationCircle.status == AnimationStatus.completed
                      ? _ctrlAnimationCircle.reverse()
                      : _ctrlAnimationCircle.forward();
                });
              },
            ),
          ),
          Positioned(
            bottom: 10,
            width: pxUnit(375),
            child: MdsWidthButton(
              text: '提交',
              onPressed: _semiSubmit,
            ),
          ),
        ],
      ),
    );
  }
}

class FlowAnimatedCircle extends FlowDelegate {
  final double radius;
  FlowAnimatedCircle(this.radius);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (radius == 0) {
      return;
    }
    double x = 0;
    double y = 0;
    for (int i = 0; i < context.childCount; i++) {
      x = radius * cos(i * pi / (context.childCount + 2));
      y = radius * sin(i * pi / (context.childCount + 2));
      context.paintChild(i, transform: Matrix4.translationValues(-x, -y, 0));
    } //使用
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
