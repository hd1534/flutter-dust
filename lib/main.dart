import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                      color: Colors.yellow,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("얼굴사진"),
                          Text("80", style: TextStyle(fontSize: 30),),
                          Text("보통", style: TextStyle(fontSize: 20),),
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
                              Text("이미지"),
                              SizedBox( width: 16,),
                              Text('20°', style: TextStyle(fontSize: 20),)
                            ],
                          ),
                          Text("습도 80%"),
                          Text("풍속 10 m/s"),
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
}
