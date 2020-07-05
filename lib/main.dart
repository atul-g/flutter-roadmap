import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/goals_data.dart';
import 'package:roadmap/screens/create_roadmap_screen.dart';
import 'package:roadmap/screens/edit_roadmap_screen.dart';
import 'package:roadmap/screens/roadmap_screen.dart';
import 'screens/home_screen.dart';
import 'screens/roadmap_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

//Future<String>  hehe() async {
//  final directory = await getApplicationDocumentsDirectory();
//  // For your reference print the AppDoc directory
//  print(directory.path);
//  String path =  directory.path;
//  final file = File('$path/data.txt');
//  if(!file.existsSync()){
//    print('it does not exists');
//    file.writeAsString('hehehehehe');
//  }
//
//  print("yeah");
//  Future<String> data = file.readAsString();
//  return data;
//}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider<GoalsData>(
      create: (context) => GoalsData(),  //MAJOR NOTE: FLUTTER NOW WANTS US TO USE "create" INSTEAD OF builder IN THE Provider and ChangeNotifierProvider CLASS
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {   //TO REMOVE THE SCROLL GLOW IN THE ENTIRE APPLICATION
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
          RoadmapScreen.id: (context) => RoadmapScreen(),
          CreateRoadmap.id: (context) => CreateRoadmap(),
          EditRoadmap.id: (context) => EditRoadmap(),
        },
      ),
    );
  }
}


// removing scroll glow because i have a curved appbar. scroll glow does not look good
// with a curved appbar
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
