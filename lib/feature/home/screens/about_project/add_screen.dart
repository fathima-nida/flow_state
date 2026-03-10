import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/home/controllers/home_controllers.dart';
import 'package:to_do/feature/home/model/home_model.dart';

void addScreen(
  BuildContext context,
  WidgetRef ref,
  HomeModel project, {
  ScreenModel? screen,
}) {
  final List<String> status = [
    'Assigned',
    'Inprogress',
    'On Test',
    'Completed',
    'On Hold',
  ];

  final TextEditingController screenCntrllr = TextEditingController(
    text: screen?.screenName ?? '',
  );
  final TextEditingController devprNameCntrllr = TextEditingController(
    text: screen?.developerName ?? '',
  );
  final TextEditingController aboutScreenCntrllr = TextEditingController(
    text: screen?.aboutScreen ?? '',
  );

  String? selectedValue = screen?.status;

  final formkey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          final repo = ref.read(homeRepoProvider);

          return Dialog(
            backgroundColor: AppColors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.projectName,
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        dropdownColor: AppColors.card,
                        borderRadius: BorderRadius.circular(14),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                          size: 28,
                        ),
                        decoration: InputDecoration(
                          labelText: "Status",
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: AppColors.card,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          border: OutlineInputBorder(
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
                        value: selectedValue,
                        validator: (v) =>
                            v == null ? 'Please select status' : null,
                        items: status.map((String value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() => selectedValue = newValue);
                        },
                      ),

                      const SizedBox(height: 10),

                      TextFormField(
                        controller: screenCntrllr,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Enter screen name' : null,
                        decoration: InputDecoration(
                          labelText: 'Screen Name',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
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

                      TextFormField(
                        controller: devprNameCntrllr,
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter developer name'
                            : null,
                        decoration: InputDecoration(
                          labelText: 'Developer Name ',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade600,
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

                      SizedBox(height: 5),

                      Text(
                        'About Screen',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,
                        ),
                      ),

                      TextFormField(
                        controller: aboutScreenCntrllr,
                        validator: (v) => v == null || v.isEmpty
                            ? 'Enter about screen'
                            : null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 5,
                        maxLines: 10,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            if (!formkey.currentState!.validate()) return;
                            String id = DateTime.now().millisecondsSinceEpoch
                                .toString();
                            final newScreen = ScreenModel(
                              id: id,
                              status: selectedValue!,
                              screenName: screenCntrllr.text.trim(),
                              developerName: devprNameCntrllr.text.trim(),
                              aboutScreen: aboutScreenCntrllr.text.trim(),
                              addedDate: DateTime.now(),
                              todayUpdate: [],
                            );

                            if (screen != null) {
                              await repo.updateProject(project.id, {
                                'SCREENS': FieldValue.arrayRemove([
                                  screen.toMap(),
                                ]),
                              });
                            }

                            await repo.updateProject(project.id, {
                              'SCREENS': FieldValue.arrayUnion([
                                newScreen.toMap(),
                              ]),
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
            ),
          );
        },
      );
    },
  );
}
