import 'package:flutter/material.dart';
import 'package:roadmap/constants.dart';
import 'package:roadmap/widgets/custom_appbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/goals_data.dart';

class CreateRoadmap extends StatefulWidget {
  static const id = 'create_roadmap';

  @override
  _CreateRoadmapState createState() => _CreateRoadmapState();
}

class _CreateRoadmapState extends State<CreateRoadmap> {
  String goalTitle;
  String goalPlan;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'New Roadmap'),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            SizedBox(height: 20,),
            Text(
              'Title:',
              style: TextStyle(
                color: blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              maxLines: 1,
              maxLength: 40,
              decoration: InputDecoration(
                labelText: "Give your new goal a title",
                labelStyle: TextStyle(
                  color: blackColor,
                  fontFamily: 'Ubuntu',
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide( color: blackColor),
                ),
              ),
              onChanged: (String value) {
                goalTitle = value;
              },
            ),
            SizedBox(height: 15),
            Text(
              'Plan:',
              style: TextStyle(
                color: blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLength: 300,
              maxLines: null,
              autocorrect: true,
              decoration: InputDecoration(
                labelText: 'Enter each step involved in separate new lines ⏎',
                labelStyle: TextStyle(
                  color: blackColor,
                  fontFamily: 'Ubuntu',
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide( color: blackColor),
                )
              ),
              onChanged: (String value) {
                goalPlan = value;
              }
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if(goalTitle=='' || goalTitle==null || goalPlan=='' || goalPlan==null){
              Fluttertoast.showToast(
                  msg: "Please enter all the fields",
              );
            }
            else{
              Provider.of<GoalsData>(context, listen: false).addGoal(goalTitle, goalPlan);
              Navigator.pop(context);
            }
          },
          tooltip: "Save this Roadmap",
          foregroundColor: Colors.white,
          backgroundColor: blackColor,
          elevation: 10,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: greyBorder,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          label: Text(
            'Save',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w200,
              fontSize: 25,
            ),
          ),
          icon: Icon(
            Icons.save,
            size: 30,
          ),
        ),
      ),
    );
  }
}



