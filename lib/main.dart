import 'package:flutter/material.dart';
import 'package:flutter_dust/bloc/air_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/air_result.dart';

void main() {
  runApp(MyApp());
}

final airBloc = AirBloc();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Main()
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<AirResult>(
          stream: airBloc.airResult,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? buildBody(snapshot.data)
                : CircularProgressIndicator();
          }
        ),
      ),
    );
  }

  Widget buildBody(AirResult result) {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("현재 위치 미세먼지", style: TextStyle(fontSize: 30) ,),
                SizedBox(height:  18,),
                Card(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        color: getColor(result),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(getIcon(result)),
                            Text("${result.data.current.pollution.aqius}", style: TextStyle(fontSize: 30),),
                            Text(getString(result), style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.network("https://airvisual.com/images/${result.data.current.weather.ic}.png", width: 32, height: 32,),
                                SizedBox( width: 16,),
                                Text('${result.data.current.weather.tp}°', style: TextStyle(fontSize: 20),)
                              ],
                            ),
                            Text("습도 ${result.data.current.weather.hu}%"),
                            Text("풍속 ${result.data.current.weather.ws} m/s"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height:  18,),
                ClipRRect(  // 끝을 둥글게
                  borderRadius: BorderRadius.circular(30),
                  child: RaisedButton(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    color: Colors.orange,
                    child: Icon(Icons.refresh, color: Colors.white),
                    onPressed: () {
                      airBloc.fetch();
                    },
                  ),
                )
              ],
            ),
          ),
        );
  }

  Color getColor(AirResult result) {
    if (result.data.current.pollution.aqius <= 50)
      return Colors.greenAccent;
    if (result.data.current.pollution.aqius <= 100)
      return Colors.yellow;
    if (result.data.current.pollution.aqius <= 150)
      return Colors.orange;
    return Colors.red;

  }

  String getString(AirResult result) {
    if (result.data.current.pollution.aqius <= 50)
      return "좋음";
    if (result.data.current.pollution.aqius <= 100)
      return "보통";
    if (result.data.current.pollution.aqius <= 150)
      return "나쁨";
    return "최악";
    
  }

  IconData getIcon(AirResult result) {
    if (result.data.current.pollution.aqius <= 50)
      return Icons.tag_faces;
    if (result.data.current.pollution.aqius <= 100)
      return Icons.face;
    if (result.data.current.pollution.aqius <= 150)
      return Icons.thumb_down;
    return Icons.warning;
  }
}
