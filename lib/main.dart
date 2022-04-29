import 'package:flutter/material.dart';

import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Strings.dart';

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
      home: MyHomePage(title: Strings.appbar),
    );
  }
}




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool toggle = true;
  List widgets=[];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      if(_counter==5){
        toggle=!toggle;
      }
    });
  }

  void btnPress(){
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color.fromARGB(12, 12, 12, 123),
      ),
      // body: Container(
      //   color: Colors.blue,
      //   margin: new EdgeInsets.all(10),
      //   child: Column(
      //     children: <Widget>[
      //       new ListView.builder(
      //         itemCount: widgets.length,
      //         itemBuilder: (BuildContext context,int position){
      //           return getRow(position);
      //         },
      //       ),
      //       Text(
      //         'You have pushed the button this many times:',
      //         style: new TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      body:new ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context,int position){
          return getRow(position);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getRow(int i) {
    final alreadySaved = true;
    final TextEditingController _controller = new TextEditingController();

    if(i==0){
      return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            new ListTile(
                title: new Text("${widgets[i]["id"]}"),
                leading: new Icon(
                  alreadySaved ? Icons.fact_check : Icons.fact_check_outlined,
                  color: alreadySaved ? Colors.red : null,
                ),
                trailing: new Icon(
                  alreadySaved ? Icons.fact_check : Icons.fact_check_outlined,
                  color: alreadySaved ? Colors.red : null,
                ),
                onTap: (){
                  // if (alreadySaved) {
                  //   _saved.remove(pair);
                  // } else {
                  //   _saved.add(pair);
                }
            ),
            new TextField(
              controller:_controller ,
              decoration: new InputDecoration(
                hintText: '请输入内容',
              ),
            ),
          ],
        ),
      );
    }else if(i==1){
      return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            new TextField(
              controller:_controller ,
              decoration: new InputDecoration(
                hintText: '请输入内容',
              ),
            ),
          ],
        ),
      );
    }else if(i==2){
      return new Padding(
        padding: new EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            new TextButton(
                onPressed: btnPress,
                child: Row(
                  children: <Widget>[

                  ],
                )),
          ],
        ),
      );
    }


  }

  //数据请求
  loadData() async{
    Dio dio = Dio();

    // dio.options.baseUrl = "https://sx.water-mind.com";
    // dio.options.connectTimeout = 5000; //5s
    // dio.options.receiveTimeout = 5000;
    // dio.options.headers = {HttpHeaders.cookieHeader: 'csToken=bbc1be2113374bffb5b51e7788dce38b',HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'};

    // Response response = await dio.post("https://sx.water-mind.com/cs_s/applyModule/findOne",
    //     data:{"apply_id":"cd2ec48d7b0f4c4f96d5fde2e82dfe06", "module_id":"d9a1f92346354d5cae0b601449e13f6f"},
    //     options: Options(headers: {HttpHeaders.cookieHeader: 'csToken=bbc1be2113374bffb5b51e7788dce38b',HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'}));
    // print(response);

    Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    http.Response response = await http.get(uri);
    setState(() {
      // Map<String, dynamic> jsonMap = json.decode(response.body);
      // Home home = Home.fromJson(jsonMap);
      // widgets=home.obj.htmlzList;
      widgets=json.decode(response.body);
      print("object"+widgets.toString());
    });
  }//网络请求方法


}

