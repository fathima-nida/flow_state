import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  final String id;
  final String projectName;
  final String startingDate;
  final String deadLine;
  final String endingDate;
  final String aboutProject;
  final String status;
  final DateTime addedDate;
   List<ScreenModel> screens;

  HomeModel({
    required this.id,
    required this.projectName,
    required this.startingDate,
    required this.deadLine,
    required this.endingDate,
    required this.aboutProject,
    required this.status,
    required this.addedDate,
    required this.screens,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'PROJECT_NAME': projectName,
      'STARTING_DATE': startingDate,
      'ENDING_DATE': endingDate,
      'DEADLINE': deadLine,
      'ABOUT_PROJECT': aboutProject,
      'STATUS': status,
      'ADDED_DATE': addedDate,
      'SCREENS': screens.map((e) => e.toMap()).toList(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      id: map['ID'] ?? '',
      projectName: map['PROJECT_NAME'] ?? '',
      startingDate: map['STARTING_DATE'] ?? '',
      deadLine: map['DEADLINE'] ?? '',
      endingDate: map['ENDING_DATE'] ?? '',
      aboutProject: map['ABOUT_PROJECT'] ?? '',
      status: map['STATUS'] ?? '',
      addedDate: map['ADDED_DATE'] is Timestamp
          ? (map['ADDED_DATE'] as Timestamp).toDate()
          : DateTime.tryParse(map['ADDED_DATE']?.toString() ?? '') ??
              DateTime.now(),
      screens: (map['SCREENS'] as List<dynamic>? ?? [])
          .map((e) => ScreenModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

// --------------------------------------------------
class ScreenModel {
  final String id;
   String status;
  final String screenName;
  final String developerName;
  final String aboutScreen;
  final DateTime addedDate;
  final List<TodayUpdateModel> todayUpdate;


  ScreenModel({
    required this.id,
    required this.status,
    required this.screenName,
    required this.developerName,
    required this.aboutScreen,
    required this.addedDate,
    required this.todayUpdate,
  });

  Map<String, dynamic> toMap() => {
        'ID': id,
        'STATUS': status,
        'SCREEN_NAME': screenName,
        'DEVELOPER_NAME': developerName,
        'ABOUT_SCREEN': aboutScreen,
        'ADDED_DATE': addedDate,
        'TODAY_UPDATE': todayUpdate.map((e) => e.toMap()).toList(),
      };

  factory ScreenModel.fromMap(Map<String, dynamic> map) => ScreenModel(
        id: map['ID'],
        status: map['STATUS'],
        screenName: map['SCREEN_NAME'],
        developerName: map['DEVELOPER_NAME'],
        aboutScreen: map['ABOUT_SCREEN'],
        addedDate: map['ADDED_DATE'] is Timestamp
          ? (map['ADDED_DATE'] as Timestamp).toDate()
          : DateTime.tryParse(map['ADDED_DATE']?.toString() ?? '') ??
              DateTime.now(),
        todayUpdate: (map['TODAY_UPDATE'] as List<dynamic>? ?? [])
    .map((e) => TodayUpdateModel.fromMap(e as Map<String, dynamic>, e['ID'] ?? ''))
    .toList(),

            
      );
}


class TodayUpdateModel {
  String id;
  String date;
  String workUpdation;
  DateTime addedDate;

  TodayUpdateModel({required this.id,required this.date,required this.workUpdation,required this.addedDate});
  Map<String, dynamic> toMap() {
    return {
      'ID': id ,
      'DATE': date,
      'WORK_UPDATION': workUpdation,
      'ADDED_DATE': addedDate ,
    };
  }

  factory TodayUpdateModel.fromMap(
    Map<String, dynamic> map,
    String docId,
  ) {
    return TodayUpdateModel(
      id: docId,
      date: map['DATE']?.toString() ?? '',
      workUpdation: map['WORK_UPDATION']?.toString() ?? '',
      addedDate: map['ADDED_DATE'] is Timestamp
          ? (map['ADDED_DATE'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
