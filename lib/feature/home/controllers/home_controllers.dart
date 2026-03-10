import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:to_do/core/provider/firebase_provider.dart';
import 'package:to_do/feature/home/model/home_model.dart';
import 'package:to_do/feature/home/repository/home_repo.dart';

final homeRepoProvider = Provider(
  (ref) => HomeRepo(ref.watch(firebaseServiceProvider)),
);

final homelistProvider = StreamProvider<List<HomeModel>>(
  (ref)=>ref.watch(homeRepoProvider).getProjects(),
);


Future<void> deleteTodayUpdate({
  required String projectId,
  required String screenId,
  required String updateId,
  required WidgetRef ref,
}) async {
  final repo = ref.read(homeRepoProvider);

  final project = ref.read(homelistProvider).value!
      .firstWhere((p) => p.id == projectId);

  final updatedScreens = project.screens.map((screen) {
    if (screen.id == screenId) {
      final updatedUpdates = screen.todayUpdate
          .where((u) => u.id != updateId)
          .toList();

      return ScreenModel(
        id: screen.id,
        status: screen.status,
        screenName: screen.screenName,
        developerName: screen.developerName,
        aboutScreen: screen.aboutScreen,
        addedDate: screen.addedDate,
        todayUpdate: updatedUpdates,
      );
    }
    return screen;
  }).toList();

  await repo.updateProject(projectId, {
    'SCREENS': updatedScreens.map((e) => e.toMap()).toList(),
  });
}

final searchProvider = StateProvider<String>((ref) => "");