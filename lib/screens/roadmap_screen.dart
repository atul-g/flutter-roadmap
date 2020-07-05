import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roadmap/goals_data.dart';
import 'package:roadmap/widgets/custom_appbar.dart';
import 'package:roadmap/constants.dart';

class RoadmapScreen extends StatefulWidget {
  static const String id = 'roadmap_screen';

  @override
  _RoadmapScreenState createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<GoalsData>(
        builder: (context, goalsData, child) {
          //print(goalsData.plan_isdone[goalsData.curIndex]);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: CustomAppBar(title: 'Roadmap', showDelete: true, index:goalsData.curIndex),

            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, 'edit_roadmap');
              },
              tooltip: "Edit this Roadmap",
              foregroundColor: Colors.white,
              backgroundColor: blackColor,
              elevation: 5,
              highlightElevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: greyBorder,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              label: Text(
                'Edit',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w200,
                  fontSize: 25,
                ),
              ),
              icon: Icon(
                Icons.edit,
                size: 30,
              ),
            ),

            body: goalsData.goalsCount!=0 ? CustomScrollView(  //MAJOR NOTE: THIS HAS TO BE PUT INSIDE A TERNARY CONDITION BECAUSE FOR SOME REASON, AFTER DELETING A
              slivers: <Widget>[                               // GOAL FROM THE ROADMAP SCREEN, THIS ROADMAP WIDGET GETS BUILT AGAIN FOR A TINY MOMENT AGAIN, AND WHEN IT GETS BUILT, THE VALUE OF curIndex IS NOT UPDATED SINCE
                SliverAppBar(                                   //  WE HAD JUST DELETED AN ELEMNT FROM THE MAIN GOALS DATA LISTS, THIS CAN LEAD TO AN OUT OF RANGE ERROR WHEN DELETING A GOAL WHICH IS IN THE LAST POSITION OF
                  expandedHeight: 70,                           //  THE LIST.
                  title: Text(
                    '${goalsData.goal_titles[goalsData.curIndex]}',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      color: blackColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  elevation: 10,
                  forceElevated: true,
                  automaticallyImplyLeading: false,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30))),
                ),
                SliverFillRemaining(
                  child: ListView.separated(
                    addRepaintBoundaries: true,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: <Widget>[
                          Flexible(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: blackColor,
                                  border: Border.all(
                                    color: greyBorder,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.45),
                                      offset: Offset(6, 6),
                                      blurRadius: 5,
                                      spreadRadius: 3,
                                    )
                                  ]),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 10, 10, 20), //bottom alone is 20
                                child: Text(
                                  '${goalsData.goal_roadmap[goalsData.curIndex][index]}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  goalsData.toggleRoadmapDone(
                                      goalsData.curIndex, index);
                                });
                              },
                              child: goalsData.plan_isdone[goalsData.curIndex]
                                      [index]
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.black,
                                    )
                                  : Icon(Icons.crop_square),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              50, 0, 0, 0), //only left has margin value of 50
                          color: blackColor,
                          height: 25,
                          width: 1,
                        ),
                      );
                    },
                    itemCount:
                        goalsData.goal_roadmap[goalsData.curIndex].length,
                  ),
                )
              ],
            ) : null,
          );
        },
      ),
    );
  }
}
