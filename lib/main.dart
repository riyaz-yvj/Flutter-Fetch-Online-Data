
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://animechan.vercel.app/api/quotes";
  List data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept" : "application/json"}
    );
    print(response.body);

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;
    });
    return "Success";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Fetch Online data')),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (_, int index){
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                Text(data[index]['anime'], style: TextStyle(fontWeight: FontWeight.bold),),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                Text(data[index]['character']),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                Text(data[index]['quote']),
                Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
              ],
            ),
          );
        },
      ),
    );
  }
}
