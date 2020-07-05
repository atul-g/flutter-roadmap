import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class GoalsData extends ChangeNotifier {
  List <String> goal_titles = ['Create own startup', 'Give a speech on TedX', 'Become a pirate king'];
  List <List<String>> goal_roadmap = [['sample text that overflows oooooooooooooooooooooooooooooo', 'sample text'], ['Read everything in speaking.io', 'Join a speakers club', 'Overcome stage fear', 'Learn the art of presentation','Think of an idea you want to talk about', 'Get accepted in speaking conferences', 'Approach the conducting board', 'Get a speaking slot'], ['Eat a lot', 'Beat the Yonkous', 'Reach laugh tale']];
  List <List<bool>> plan_isdone = [[false, false], [false, false, false, false, false, false, false, false], [false, false, false]];
  int curIndex;

//  GoalsData(data) {
//    //trial = data;
//    print(trial);
//  }

  int get goalsCount {
    return goal_titles.length;
  }

  void setIndex(int ind){
    curIndex = ind;
  }

  List<String> getRoadmap(int index){
    return goal_roadmap[index];
  }

  void addGoal(String newGoal, String goalRoadMap){
    goal_titles.add(newGoal);
    var temp = goalRoadMap.split('\n');
    goal_roadmap.add(temp);
    plan_isdone.add(List<bool>.filled(temp.length, false, growable: true));
    notifyListeners();
  }

  void toggleRoadmapDone (int goalIndex, int index){
    plan_isdone[goalIndex][index] = plan_isdone[goalIndex][index]==true ? false : true;
    notifyListeners();
  }

  void deleteGoal(int index){
    goal_titles.removeAt(index);
    goal_roadmap.removeAt(index);
    plan_isdone.removeAt(index);
    notifyListeners();
  }

  void updateFields(String editedTitle, String editedPlan, int index){
    List<String> newPlan = editedPlan.split("\n");
    List<String> plan = goal_roadmap[index];
    String title = goal_titles[index];

    List<bool> temp = [];
    for(int i=0; i<newPlan.length; i++) {
      if(plan.contains(newPlan[i])) {
        bool t = plan_isdone[index][goal_roadmap[index].indexOf(newPlan[i])];
        temp.add(t);
      }
      else temp.add(false);
    }

    plan_isdone[index] = temp;
    goal_roadmap[index] = newPlan;

    if(title != editedTitle) goal_titles[index] = editedTitle;

    notifyListeners();
  }

}