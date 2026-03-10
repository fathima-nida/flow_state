import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/home/screens/about_project/add_screen.dart';
import 'package:to_do/feature/home/screens/about_project/widget/delete_alert.dart';
import 'package:to_do/feature/home/controllers/home_controllers.dart';
import 'package:to_do/feature/home/model/home_model.dart';

void editdltAlert(
  BuildContext context,
  WidgetRef ref,
  HomeModel project,
  ScreenModel screen,
) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit or Delete',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color.fromARGB(255, 144, 16, 6),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Would you like to delete or edit?',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    addScreen(context, ref, project, screen: screen);
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.accent15,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.accent, width: 0.5),
                    ),
                    child: Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    deleteAlert(
                      context,
                      'Do you want to delete this screen?',
                      onYesPressed: () async {
                       await ref.read(homeRepoProvider).updateProject(project.id, {
              'SCREENS': FieldValue.arrayRemove([screen.toMap()])
            });
                        },
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.accent15,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.accent, width: 0.5),
                    ),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


