import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';

void main(){
  runApp(
    MaterialApp(
      title: "IO",
      home: Home(),
    )
  );
}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>{
  final _enterData=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Read/Write'),
        centerTitle:true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller:_enterData,
            decoration: InputDecoration(
              labelText:'Write Something',
            ),
          ),
          subtitle: FlatButton(
            onPressed: (){
              writeData(_enterData.text);
            },
            child: Column(
              children: <Widget>[
                Text('Save Data'),
                Padding(padding: EdgeInsets.all(14.5),),
                FutureBuilder(
                  future: readData(),
                  builder: (BuildContext ctx,AsyncSnapshot snapshot){
                    if(snapshot.hasData)return Text(snapshot.data);
                    return null;
                  }
                ),
              ],
            ),
          ),  
        ),
      ),
    );
  }

}

Future<String> get _localPath async{
    final directory=await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async{
    final path=_localPath;
    return File('$path/data.txt');
  }
  Future<File> writeData(String msg)async{
    final file=await _localFile;
    return file.writeAsString('$msg');
  }
  Future<String> readData()async{
    try{
      final file=await _localFile;
      String data=await file.readAsString();

      return data;
    }catch(exp){
      return "No data present";
    }
  }