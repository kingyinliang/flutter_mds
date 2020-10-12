import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dfmdsapp/components/appBar.dart';
import 'package:dfmdsapp/api/api/index.dart';
import 'package:dfmdsapp/utils/storage.dart';
import 'package:dfmdsapp/components/pull_refresh.dart';
import 'package:dfmdsapp/components/no_data.dart';

class CraftHome extends StatefulWidget {
  final arguments;
  CraftHome({Key key, this.arguments}) : super(key: key);

  @override
  _CraftHomeState createState() => _CraftHomeState();
}

class _CraftHomeState extends State<CraftHome> {
  @override
  Widget build(BuildContext context) {
//    TextEditingController mControll3 = TextEditingController();

//    String titleData = '工艺控制';
//    void onChanged(val){
//      setState(() {
//        titleData = val;
//      });
//    }
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xffF5F5F5),
        appBar: MdsAppBarWidget(titleData: '工艺控制'),
        body: Container(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFFF5F5F5),
              automaticallyImplyLeading: false,
              title: HeadSearchWidget(),
              elevation: 1.5,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(42),
                child: Material(
                  color: Colors.white,
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Color(0xFF1677FF),
                    labelColor: Color(0xFF1677FF),
                    labelStyle: TextStyle(fontSize: 17),
                    unselectedLabelColor: Color(0xFF333333),
                    unselectedLabelStyle: TextStyle(fontSize: 17),
                    tabs: <Widget>[
                      Tab(text: '待维护'),
                      Tab(text: '已保存'),
                      Tab(text: '已提交'),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Color(0xFFF5F5F5),
            body: TabBarView(
              children: <Widget>[
                ListItemWidget(type: 'not', url: widget.arguments['url']),
                ListItemWidget(type: 'save', url: widget.arguments['url']),
                ListItemWidget(type: 'submit', url: widget.arguments['url']),
              ],
            )
          )
        )
      )
    );
  }
}

class HeadSearchWidget extends StatefulWidget {
  HeadSearchWidget({Key key}) : super(key: key);
  @override
  _HeadSearchWidgetState createState() => _HeadSearchWidgetState();
}

class _HeadSearchWidgetState extends State<HeadSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
      height: 44,
      color: Color(0xFFF5F5F5),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x0A000000),
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        child: TextField(
          style: TextStyle(color: Color(0xFF999999), fontSize: 13),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            prefixIcon: Icon(Icons.search, color: Color(0xFF999999)),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: '锅序号',
            fillColor: Color(0xFF999999),
          ),
        ),
      ),
    );
  }
}

class ListItemWidget extends StatefulWidget {
  final String type;
  final String pot;
  final String potName;
  final String url;
  final String workingType;
  ListItemWidget(
      {Key key,
      @required this.url,
      @required this.pot,
      @required this.potName,
      @required this.type,
      @required this.workingType})
      : super(key: key);

  @override
  _ListItemWidgetState createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget>
with AutomaticKeepAliveClientMixin {
  List listviewList = [];
  int current = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration.zero,
            () => setState(() {
          _initState();
        }));
  }

  _initState() async {
    getData();
  }

  Future<void> getData() async {
    try {
      var workShopId = await SharedUtil.instance.getStorage('workShopId');
      var res = await Sterilize.sterilizeCraftListApi({
        'workShop': workShopId,
        'type': widget.type,
        'current': '1',
        'size': '10',
      });
      listviewList = res['data']['records'];
      setState(() {});
    } catch (e) {}
  }

  Future<bool> _pull() async {

    try {
      current++;
      var workShopId = await SharedUtil.instance.getStorage('workShopId');
      var res = await Sterilize.sterilizeCraftListApi({
        'workShop': workShopId,
        'type': widget.type,
        'current': current,
        'size': '10',
      });
      listviewList.addAll(res['data']['records']);
      setState(() {});
      if (current * 10 >= res['data']['total']) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return true;
    }
  }

  Future<void> _refresh() async {
    current = 1;
    await getData();
  }

  Widget pullR() {
    return PullRefresh(
      data: listviewList,
      pull: _pull,
      refresh: _refresh,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.asset("lib/assets/images/pot.jpg"),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('第${listviewList[index]['potOrder']}锅',
                        style: TextStyle(fontSize: 17.0)),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Text(
                    '${listviewList[index]['materialCode']} ${listviewList[index]['materialName']}'),
                Text(
                    '${listviewList[index]['orderNo']}-${listviewList[index]['checkStatusName']}'),
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, '/sterilize/craft/materialList',
                  arguments: {
                    'potName': widget.potName,
                    'potNum': listviewList[index],
                  });
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return listviewList.length != 0 ? pullR() : NoDataWidget();
  }
}