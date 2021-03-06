import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/appBar.dart';

class HeaderDetail extends StatefulWidget {
  HeaderDetail({Key key, this.detialArray, this.callBack}) : super(key: key);
  final List detialArray;
  final callBack;
  @override
  _HeaderDetailState createState() => _HeaderDetailState();
}

class _HeaderDetailState extends State<HeaderDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
        padding: EdgeInsets.all(10.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: AlignmentDirectional.center,
                child: Image.asset("lib/assets/images/potDetail.jpg"),
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '${widget.detialArray[0]}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '${widget.detialArray[1]}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          '???????????????${widget.detialArray[2]}',
                        )
                    ),
                    Text('????????????${widget.detialArray[3]}'),
                  ],
                ),
              ),
              flex: 2,
            )
          ],
        ),
    );
  }
}
