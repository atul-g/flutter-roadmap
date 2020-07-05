import 'package:flutter/material.dart';
import 'package:roadmap/constants.dart';
import 'package:roadmap/screens/roadmap_screen.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/goals_data.dart';

class GoalCard extends StatelessWidget {
  String goalTitle;
  int index;
  GoalCard({this.goalTitle, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<GoalsData>(context, listen: false).setIndex(index);
        Navigator.pushNamed(context, RoadmapScreen.id);
      },
      child: Container(
        padding: EdgeInsets.all(10), //this is to indent the text inside from the container border.
        decoration: BoxDecoration(
            color: blackColor,
            border: Border.all(
              color: greyBorder,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(6, 6),
                blurRadius: 5,
                spreadRadius: 3,
              )
            ]),
        child: Text(
          '$goalTitle',
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w100,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
