import 'package:flutter/material.dart';
import 'package:roadmap/constants.dart';
import 'package:roadmap/goals_data.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/widgets/custom_appbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditRoadmap extends StatefulWidget {
  static const String id = 'edit_roadmap';
  @override
  _EditRoadmapState createState() => _EditRoadmapState();
}

class _EditRoadmapState extends State<EditRoadmap> {
  String goalTitle;
  String goalPlan;
  String finalGoalTitle;  //this is where the edited goal title will be kept
  String finalGoalPlan;   //this is where the edited goal roadmap be kept

  TextEditingController titletextcontroller;
  TextEditingController plantextcontroller;

  @override
  Widget build(BuildContext context) {
    goalTitle = Provider.of<GoalsData>(context).goal_titles[Provider.of<GoalsData>(context).curIndex];
    goalPlan = Provider.of<GoalsData>(context).goal_roadmap[Provider.of<GoalsData>(context).curIndex].join("\n");

    titletextcontroller = TextEditingController(
      text: goalTitle,
    );

    plantextcontroller = TextEditingController(
      text: goalPlan,
    );

    finalGoalPlan = goalPlan;
    finalGoalTitle = goalTitle;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Edit Roadmap'),
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
              controller: titletextcontroller,
              maxLines: 1,
              maxLength: 40,
              decoration: InputDecoration(
                labelText: "Edit title",
                labelStyle: TextStyle(
                  color: blackColor,
                  fontFamily: 'Ubuntu',
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide( color: blackColor),
                ),
              ),
              onChanged: (String value) {
                finalGoalTitle = value;
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
                controller: plantextcontroller,
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
                  finalGoalPlan = value;
                }
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if(finalGoalTitle=='' || finalGoalTitle==null || finalGoalPlan=='' || finalGoalPlan==null){
              Fluttertoast.showToast(
                msg: "Please enter all the fields",
              );
            }
            else{
              Provider.of<GoalsData>(context, listen: false).updateFields(finalGoalTitle, finalGoalPlan, Provider.of<GoalsData>(context, listen: false).curIndex);  //CHANGE THIS LINE TO A NEW FUNCTION
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

