import 'package:flutter/material.dart';
import 'package:roadmap/goals_data.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/widgets/goal_card.dart';
import 'package:roadmap/constants.dart';
import 'package:roadmap/widgets/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 250,
                color: Colors.black,
                child: Center(
                  child: Text(
                    'Roadmap',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  return showAboutDialog(
                    children: <Widget>[
                      Text(
                        'Created by Atul Gopinathan :D\nProject Site: github.com/atul-g/flutter-roadmap',
                      )
                    ],
                    context: context,
                    applicationName: 'Roadmap',
                    applicationVersion: '1.0',
                    applicationIcon: Icon(
                      Icons.local_florist,
                      color: blackColor,
                      size: 60,
                    ),
                  );
                },
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'About',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Ubuntu',
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create_roadmap');
                },
                child: Text(
                  'Add Goals',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'Ubuntu',
                    fontSize: 30,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'My Goals'),
        body: Provider.of<GoalsData>(context).goalsCount == 0
            ? NoGoalText()
            : GridList(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, 'create_roadmap');
          },
          tooltip: "Create a new Roadmap",
          foregroundColor: Colors.white,
          backgroundColor: blackColor,
          elevation: 5,
          highlightElevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: greyBorder,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          label: Text(
            'Create',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w200,
              fontSize: 25,
            ),
          ),
          icon: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }
}



class GridList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
      padding: EdgeInsets.all(20),
      children: List.generate(Provider.of<GoalsData>(context).goalsCount, (index) {
        return GoalCard(goalTitle: Provider.of<GoalsData>(context).goal_titles[index], index: index);
      }),
    );
  }
}

class NoGoalText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shadowColor: greyBorder,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: greyBorder,
              width: 1,
            )),
        elevation: 15,
        child: Container(
          width: 330,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Icon(
                Icons.error,
                size: 80,
                color: Colors.black, //less opaque version of blueFont color.
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 30), //bottom alone is 30
                child: Text(
                  'Whoops! Nothing to show here.\n\nThink of your goals and start by creating a roadmap first :D',
                  style: TextStyle(
                      color: blackColor,
                      fontFamily: 'Ubuntu',
                      fontSize: 20,
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
