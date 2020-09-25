import 'package:dfmdsapp/pages/common/no_net.dart';
import 'package:dfmdsapp/pages/login/login.dart';
import 'package:dfmdsapp/pages/index/index.dart';
import 'package:dfmdsapp/pages/index/user/user_info.dart';
import 'package:dfmdsapp/pages/index/user/versions.dart';
import 'package:dfmdsapp/pages/index/user/update_pasword.dart';
import 'package:dfmdsapp/pages/sterilize/barcode.dart';
import 'package:dfmdsapp/pages/sterilize/craft/list.dart';
import 'package:dfmdsapp/pages/sterilize/craft/materialList.dart';
import 'package:dfmdsapp/pages/sterilize/craft/materialAdd.dart';
import 'package:dfmdsapp/pages/sterilize/craft/timeAdd.dart';
import 'package:dfmdsapp/pages/sterilize/exception/home.dart';
import 'package:dfmdsapp/pages/sterilize/exception/list.dart';
import 'package:dfmdsapp/pages/sterilize/exception/add.dart';
import 'package:dfmdsapp/pages/sterilize/exception/textAdd.dart';
import 'package:dfmdsapp/pages/sterilize/list.dart';
import 'package:dfmdsapp/pages/sterilize/acceAdd/home.dart';
import 'package:dfmdsapp/pages/sterilize/acceAdd/potAdd.dart';
import 'package:dfmdsapp/pages/sterilize/acceAdd/acceReceive.dart';
import 'package:dfmdsapp/pages/sterilize/acceAdd/materialAdd.dart';
import 'package:dfmdsapp/pages/sterilize/semiReceive/home.dart';
import 'package:dfmdsapp/pages/sterilize/semiReceive/add.dart';

Map<String, Function> routers = {
  '/noNet': (contxt, {arguments}) => NoNetPage(),
  '/login': (contxt, {arguments}) => LoginPage(),
  '/home': (contxt, {arguments}) => IndexPage(arguments: arguments),
  '/user/userinfo': (contxt, {arguments}) => UserInfoPage(arguments: arguments),
  '/user/versions': (contxt, {arguments}) => VersionsPage(arguments: arguments),
  '/user/updatepasword': (contxt, {arguments}) =>
      UpdatePaswordPage(arguments: arguments),
  '/sterilize/barcode': (contxt, {arguments}) =>
      BarCodePage(arguments: arguments),
  '/sterilize/list': (contxt, {arguments}) =>
      AcceAddListPage(arguments: arguments),
  '/sterilize/craft/list': (contxt, {arguments}) =>
      CraftListPage(arguments: arguments),
  '/sterilize/craft/materialList': (contxt, {arguments}) =>
      CraftMaterialList(arguments: arguments),
  '/sterilize/craft/materialAdd': (contxt, {arguments}) =>
      CraftMaterialAdd(arguments: arguments),
  '/sterilize/craft/timeAdd': (contxt, {arguments}) =>
      CraftTimeAdd(arguments: arguments),
  '/sterilize/exception/home': (contxt, {arguments}) =>
      CraftExceptionHome(arguments: arguments),
  '/sterilize/exception/list': (contxt, {arguments}) =>
      CraftExceptionList(arguments: arguments),
  '/sterilize/exception/add': (contxt, {arguments}) =>
      ExceptionAdd(arguments: arguments),
  '/sterilize/exception/textAdd': (contxt, {arguments}) =>
      ExceptionTextAdd(arguments: arguments),
  '/sterilize/acceAdd/home': (contxt, {arguments}) =>
      AcceAddHomePage(arguments: arguments),
  '/sterilize/acceAdd/potAdd': (contxt, {arguments}) =>
      PotAddPage(arguments: arguments),
  '/sterilize/acceAdd/acceReceive': (contxt, {arguments}) =>
      AcceReceivePage(arguments: arguments),
  '/sterilize/acceAdd/materialAdd': (contxt, {arguments}) =>
      MaterialAddPage(arguments: arguments),
  '/sterilize/semiReceive/home': (contxt, {arguments}) =>
      SemiReceivePage(arguments: arguments),
  '/sterilize/semiReceive/add': (contxt, {arguments}) =>
      AddSemiReceivePage(arguments: arguments),
};
