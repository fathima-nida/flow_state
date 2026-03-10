import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/home/screens/detailed_screen/widget/calender_picker.dart';
import 'package:to_do/feature/home/controllers/home_controllers.dart';
import 'package:to_do/feature/home/model/home_model.dart';

void addProject(BuildContext context, WidgetRef ref, HomeModel? projectData) {
  final TextEditingController prjctNameCntrllr = TextEditingController();
  final TextEditingController staringdateCntrllr = TextEditingController();
  final TextEditingController deadLineCntrllr = TextEditingController();
  final TextEditingController aboutAppCntrllr = TextEditingController();
  final TextEditingController endingDateCntrllr = TextEditingController();

  final List<String> status = [
    'Starting',
    'Inprogress',
    'Pending',
    'Onhold',
    'Completed',
  ];
  final formkey = GlobalKey<FormState>();

  // if open edit
  String? selectedValue = projectData?.status;

  prjctNameCntrllr.text = projectData?.projectName ?? '';
  staringdateCntrllr.text = projectData?.startingDate ?? '';
  deadLineCntrllr.text = projectData?.deadLine ?? '';
  endingDateCntrllr.text = projectData?.endingDate ?? '';
  aboutAppCntrllr.text = projectData?.aboutProject ?? '';

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
                        projectData == null
                            ? 'Adding New Project'
                            : 'Editing Project',
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

                        validator: (value) =>
                            value == null ? "Please select a status" : null,
                        value: selectedValue,
                        items: status
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (newValue) {
                          setState(() => selectedValue = newValue);
                        },
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Project Name',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        controller: prjctNameCntrllr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your project name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Project Name ',
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

                      const SizedBox(height: 10),
                      Text(
                        'Starting Date',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,
                        ),
                      ),

                      CalendarPickerContainer(
                        hintText: 'Select date',
                        controller: staringdateCntrllr,
                      ),

                      SizedBox(height: 8),
                      Text(
                        'DeadLine Date',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,
                        ),
                      ),

                      CalendarPickerContainer(
                        hintText: 'Select date',
                        controller: deadLineCntrllr,
                      ),

                       SizedBox(height: 8),
                       if(selectedValue=='Completed')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ending Date',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 14,
                            ),
                          ),
                           CalendarPickerContainer(
                        hintText: 'Select date',
                        controller: endingDateCntrllr,
                      ),

                      SizedBox(height: 8),
                        ],
                      ),

                     
                      

                      Text(
                        'About App',
                        style: TextStyle(
                          color: AppColors.secondary,
                          fontSize: 14,
                        ),
                      ),
                      TextFormField(
                        controller: aboutAppCntrllr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter about project';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 5,
                        maxLines: 10,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            if (formkey.currentState!.validate()) {
                              String id = DateTime.now().millisecondsSinceEpoch
                                  .toString();
                              Map<String, dynamic> data = {
                                'ID': id,
                                'PROJECT_NAME': prjctNameCntrllr.text.trim(),
                                'STARTING_DATE': staringdateCntrllr.text.trim(),
                                'DEADLINE': deadLineCntrllr.text.trim(),
                                'ENDING_DATE': endingDateCntrllr.text.trim(),
                                'ABOUT_PROJECT': aboutAppCntrllr.text.trim(),
                                'STATUS': selectedValue,
                              };
                              log('data....... : $data');
                              // repo.addProject(data);
                              if (projectData == null) {
                                //  ADD
                                
                                data['ID'] = id;
                                data['ADDED_DATE'] = DateTime.now();

                                repo.addProject(data);
                              } else {
                                //  UPDATE
                                data['ID'] = projectData.id;
                                data['ADDED_DATE'] = projectData.addedDate;
                    
                                repo.updateProject(projectData.id, data);
                              }
                              Navigator.pop(context);
                            }
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
