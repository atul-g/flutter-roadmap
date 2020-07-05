import 'package:flutter/material.dart';
import 'package:roadmap/constants.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/goals_data.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool showDelete;
  int index;
  //CustomAppBar({Key key}) : preferredSize = Size.fromHeight(70), super(key: key);
  CustomAppBar({this.title, this.showDelete=false, this.index})
      : preferredSize = Size.fromHeight(
            70); //this is my own constructor to be able to add a title too

  @override
  final Size preferredSize; //the default preferres size is 56

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 70),
      child: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: FittedBox(
          alignment: Alignment.topLeft,
          fit: BoxFit.fitWidth,
          child: Text(
            '$title',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        titleSpacing: 20,
        elevation: 10,
        //backgroundColor: Color(0xFF383DD9),
        backgroundColor: blackColor,
        actions: showDelete ? <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<GoalsData>(context, listen: false).deleteGoal(index);
              Provider.of<GoalsData>(context, listen: false).setIndex(0);  //THIS IS RELATED TO THE ERROR I WAS TALKING ABOUT IN THE ROADMAP SCREEN DART FILE.
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 15,),
        ] : null,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: greyBorder,
              width: 0.5,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))),
      ),
    );
  }
}
