import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  String houi = "nodata";
  double ido = 00;
  double keido = 00;
  double targetido = 0;
  double targetkeido = 0;

  Future<void> getLocation()async {
    //現在の位置を返す
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //北緯がプラス。南緯がマイナス。実際に使用するのは北緯
    print("緯度:" + position.latitude.toString());
    //東緯がプラス。西緯がマイナス。実際に使用するのは東緯
    print("経度: " + position.longitude.toString());
    //高度
    print("高度: " + position.altitude.toString());
    setState(() {
      ido = position.latitude.toDouble();
      keido = position.longitude.toDouble();
    });

    //テストデーター
    targetido = 35.587789665703845;
    targetkeido = 139.67458598778808;

    //現在地からターゲットのいる場所の方位
    if (targetido < ido && targetkeido > keido) {
      houi = "南西";
    } else if (targetido > ido && targetkeido > keido) {
      houi = "北西";
    } else if (targetido < ido && targetkeido < keido) {
      houi = "南東";
    } else if (targetido > ido && targetkeido < keido) {
      houi = "北東";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(ido.toString()),
            Text(keido.toString()),
            Text(houi),
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    getLocation();
  }
}
