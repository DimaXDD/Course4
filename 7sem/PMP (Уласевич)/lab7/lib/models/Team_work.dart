import 'package:flutter/material.dart';

import 'Sport.dart';


abstract class TeamSport implements Sport {
  String? _teamName;

  TeamSport(this._teamName);

  @override
  void getEquipment() {
    print('Getting team equipment');
  }

  @override
  void play();

  Future<void> fetchTeamData() async {
    await Future.delayed(Duration(seconds: 2));
    print("Team data fetched");
  }

  String? get teamName => _teamName;
  set teamName(String? name) => _teamName = name;
}


