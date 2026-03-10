import 'dart:developer';

import 'package:to_do/core/constant/firebase_const.dart';
import 'package:to_do/feature/home/model/home_model.dart';

class HomeRepo {
  final FirebaseService service;

  HomeRepo(this.service);

  Future<void> addProject(Map<String, dynamic> data) async {
    try {
      await service.projects.doc(data['ID']).set(data);
      log('project adding successfully : $data');
    } catch (e) {
      log('error adding project : $e');
    }
  }

  Stream<List<HomeModel>> getProjects() {
    return service.projects
        .orderBy('ADDED_DATE', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (doc) => HomeModel.fromMap(doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Future<void> deleteProject(String projectId) async {
    try {
      await service.projects.doc(projectId).delete();
      log("project deleting successfully");
    } catch (e) {
      log("error deleting project: $e");
    }
  }

  Future<void> updateProject(
    String projectId,
    Map<String, dynamic> data,
  ) async {
    try {
      await service.projects.doc(projectId).update(data);
      log("project updating successfully");
    } catch (e) {
      log("error updating project: $e");
    }
  }

  // get single project
  
    Future<HomeModel> getSingleProject(String projectId) async {
    log('projectId in getSingleProject : $projectId');

    final doc = await service.projects.doc(projectId).get();

    final project = HomeModel.fromMap(
      doc.data() as Map<String, dynamic>,
    );

    log('project : $project');
    return project;
  }

  Future<void> updateProjectStatus(
    String selectedValue,
    String projectId,
    Map<String, dynamic> data,
  ) async {
    try {
      HomeModel project = await getSingleProject(projectId);
      final List<ScreenModel> screens = project.screens ?? [];
      final pickScreen = screens.firstWhere(
        (element) => element.id == data['ID'],
      );
      pickScreen.status = selectedValue;
      project.screens.removeWhere((element) => element.id == pickScreen.id);
      project.screens.add(pickScreen);
      await service.projects.doc(project.id).update(project.toMap());
      log("project updating successfully");
    } catch (e) {
      log("error updating project: $e");
    }
  }
}
