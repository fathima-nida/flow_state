import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/home/screens/detailed_screen/widget/calender_picker.dart';
import 'package:to_do/feature/home/controllers/home_controllers.dart';
import 'package:to_do/feature/home/model/home_model.dart';

void todayUpdation(
  BuildContext context,
  WidgetRef ref,
  TodayUpdateModel? modeldata,
  String screenId,
  String projectid,
) {
  TextEditingController dateController = TextEditingController();
  TextEditingController wrkUpdationController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  dateController.text = modeldata?.date ?? '';
  wrkUpdationController.text = modeldata?.workUpdation ?? '';

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // final repo = ref.read(homeRepoProvider);
          return Dialog(
            backgroundColor: AppColors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      modeldata == null
                          ? "Today's updation"
                          : 'Edit Today updation',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 14,
                      ),
                    ),

                    CalendarPickerContainer(
                      hintText: 'Select date',
                      controller: dateController,
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      controller: wrkUpdationController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter work updation';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Work updation',
                        hintStyle: TextStyle(
                          color: AppColors.secondary20,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {
                          if (dateController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please select date"),
                              ),
                            );
                            return;
                          }

                          if (!formkey.currentState!.validate()) return;

                          final asyncProjects = ref.read(homelistProvider);

                          if (asyncProjects is! AsyncData) return;

                          final projects = asyncProjects.value;

                          final projectIndex = projects!.indexWhere(
                            (p) => p.id == projectid,
                          );
                          if (projectIndex == -1) return;

                          final project = projects[projectIndex];

                          final screenIndex = project.screens.indexWhere(
                            (s) => s.id == screenId,
                          );
                          if (screenIndex == -1) return;

                          final screen = project.screens[screenIndex];

                          // ---- Update today updates ----
                          final updatedUpdates = [...screen.todayUpdate];
                          final noChangeAddedDate = updatedUpdates.firstWhere(
                            (e) => e.addedDate == modeldata?.addedDate,
                          );
                          if (modeldata != null) {
                            updatedUpdates.removeWhere(
                              (e) => e.id == modeldata.id,
                            );
                          }

                          if (modeldata == null) {
                            updatedUpdates.where(
                              (e) => e.addedDate == modeldata?.addedDate,
                            );
                          }
                          updatedUpdates.add(
                            TodayUpdateModel(
                              id:
                                  modeldata?.id ??
                                  DateTime.now().millisecondsSinceEpoch
                                      .toString(),
                              date: dateController.text.trim(),
                              workUpdation: wrkUpdationController.text.trim(),
                              addedDate: noChangeAddedDate.addedDate,
                            ),
                          );

                          final updatedScreen = ScreenModel(
                            id: screen.id,
                            status: screen.status,
                            screenName: screen.screenName,
                            developerName: screen.developerName,
                            aboutScreen: screen.aboutScreen,
                            addedDate: screen.addedDate,
                            todayUpdate: updatedUpdates,
                          );

                          final updatedScreens = [...project.screens];
                          updatedScreens[screenIndex] = updatedScreen;

                          await ref
                              .read(homeRepoProvider)
                              .updateProject(projectid, {
                                'SCREENS': updatedScreens
                                    .map((e) => e.toMap())
                                    .toList(),
                              });

                          Navigator.pop(context);
                        },

                        child: Container(
                          height: 45,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: LinearGradient(
                              colors: AppColors.appBarGradient,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
