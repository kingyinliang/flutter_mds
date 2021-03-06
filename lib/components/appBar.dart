import 'package:flutter/material.dart';

class MdsAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  MdsAppBarWidget(
      {Key key, this.titleData, this.callBack, this.refresh = false})
      : super(key: key);
  final String titleData;
  final callBack;
  final bool refresh;

  @override
  _MdsAppBarWidgetState createState() => _MdsAppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(45);
}

class _MdsAppBarWidgetState extends State<MdsAppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.blue,
        tooltip: 'Back',
        onPressed: () {
          if (widget.refresh) {
            Navigator.pop(context, true);
          } else {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        '${widget.titleData}',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
      ),
      centerTitle: true,
      elevation: 1.5,
      backgroundColor: Colors.white,
      actions: <Widget>[
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.more_horiz, color: Colors.blue),
          ),
          onTap: () async {
            final result = await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(500, 75, 10, 0),
                            color: Color(0xFF4C4C4C),
                            items: <PopupMenuEntry>[
                              this.selectView(Icons.home, '้ฆ้กต', 0),
                              PopupMenuDivider(height: 1.0),
                              this.selectView(Icons.person, 'ๆ็', 2),
                          ]);
            Navigator.pushNamed(context,'/home',arguments:{
              'page': result,
            });
          },
        )
//        PopupMenuButton<String>(
//          icon: Icon(Icons.more_horiz, color: Colors.blue),
//          color: Colors.blue,
//          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//            this.selectView(Icons.home, '้ฆ้กต', '1'),
//            PopupMenuDivider(height: 1.0),
//            this.selectView(Icons.person, 'ๆ็', '2'),
//          ],
//          onSelected: (String action) {
//            switch (action) {
//              case '1':
//                print("้ฆ้กต");
//                break;
//              case '2':
//                print("ๆ็");
//                break;
//            }
//          },
//        ),
      ],
    );
  }

  selectView(IconData icon, String text, int id) {
    return PopupMenuItem(
        value: id,
        height: 35.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//            Icon(icon, color: Colors.white),
//            Text(text),
            Container(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(icon, color: Colors.white)),
            Text(text, style: TextStyle(color: Colors.white)),
          ],
        ));
  }
}
