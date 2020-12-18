import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/AirResult.dart';

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
  AirResult _result;  // = AirResult.fromJson(json.decode(response.body))

  Future<AirResult> fetchData() async {
    var response = await http.get('http://api.airvisual.com/v2/nearest_city?key=3d32f807-7034-43f7-87ce-5d6b0bd992c2');
    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }

  @override
  void initState() {
    super.initState();

    fetchData().then((airResult) {
      setState(() {
        _result = airResult;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _result == null
          ? Center(child: CircularProgressIndicator())
          :Padding(
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
                          color: getColor(_result),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("얼굴사진"),
                              Text("${_result.data.current.pollution.aqius}", style: TextStyle(fontSize: 30),),
                              Text(getString(_result), style: TextStyle(fontSize: 20),),
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
                                  Image.network("https://airvisual.com/images/${_result.data.current.weather.ic}.png", width: 32, height: 32,),
                                  SizedBox( width: 16,),
                                  Text('${_result.data.current.weather.tp}°', style: TextStyle(fontSize: 20),)
                                ],
                              ),
                              Text("습도 ${_result.data.current.weather.hu}%"),
                              Text("풍속 ${_result.data.current.weather.ws} m/s"),
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
                      onPressed: () {},
                    ),
                  )
                ],
              ),
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
}
