import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/home/controllers/home_controllers.dart';

void screenStatusUpdation(
  BuildContext context,
  WidgetRef ref,
  String status,
  String screenId,
  String projectId,
) {
  final List<String> statusList = [
    'Assigned',
    'Inprogress',
    'On Test',
    'Completed',
    'On Hold',
  ];
  final formkey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) {
      String selectedValue = status;

      return StatefulBuilder(
        builder: (context, setState) {
          final repo = ref.read(homeRepoProvider);
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: 140,
              child: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Center(
                        child: DropdownButtonFormField<String>(
                          dropdownColor: AppColors.card,
                          borderRadius: BorderRadius.circular(14),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.primary,
                            size: 28,
                          ),

                          decoration: InputDecoration(
                            hintText: "Status",
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
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: AppColors.primary,
                                width: 2,
                              ),
                            ),
                          ),

                          value: selectedValue,
                          items: statusList.map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              Map<String, dynamic> data = {
                                'ID': screenId,
                                'STATUS': selectedValue,
                              };
                              log('picking projrct id : $projectId');
                              await repo.updateProjectStatus(
                                 selectedValue,
                                projectId,
                               
                                data,
                              );

                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            height: 35,
                            width: 98,
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
