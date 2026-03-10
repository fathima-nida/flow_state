import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/home/screens/about_project/add_screen.dart';
import 'package:to_do/feature/home/screens/about_project/widget/delete_alert.dart';
import 'package:to_do/feature/home/screens/about_project/widget/edit_dlt_alert.dart';
import 'package:to_do/feature/home/screens/about_project/widget/project_status_updation.dart';
import 'package:to_do/feature/home/screens/detailed_screen/detailed_screen.dart';
import 'package:to_do/feature/home/controllers/home_controllers.dart';
import 'package:to_do/feature/home/screens/home_screen/add_project.dart';

class AboutProject extends ConsumerStatefulWidget {
  final String projectId;

  const AboutProject({super.key, required this.projectId});

  @override
  ConsumerState<AboutProject> createState() => _AboutProjectState();
}

class _AboutProjectState extends ConsumerState<AboutProject> {
  SearchController? _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projects = ref.watch(homelistProvider);
    final searchText = ref.watch(searchProvider);

    return projects.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text(e.toString()))),
      data: (list) {
        final project = list.where((e) => e.id == widget.projectId).isNotEmpty
            ? list.firstWhere((e) => e.id == widget.projectId)
            : null;

        if (project == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: Text(
                'Project not found',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }
        // final screens = project.screens;
        final screens = project.screens.where((screen) {
          final query = searchText.trim().toLowerCase();

          if (query.isEmpty) return true;

          return screen.screenName.toLowerCase().startsWith(query) ||
              screen.developerName.toLowerCase().startsWith(query);
        }).toList();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            title: Text(
              project.projectName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.appBarGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                color: AppColors.background,
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == "edit") {
                    addProject(context, ref, project);
                  } else if (value == "delete") {
                    deleteAlert(
                      context,
                      'Do you want to delete this project?',
                      onYesPressed: () {
                        ref
                            .read(homeRepoProvider)
                            .deleteProject(widget.projectId);
                      },
                    );
                  } else if (value == "status") {
                    projectStatusUpdation(
                      context,
                      ref,
                      project.status,
                      project.id,
                    );
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: "edit", child: Text("Edit")),
                  PopupMenuItem(value: "delete", child: Text("Delete")),
                  PopupMenuItem(value: "status", child: Text("Status")),
                ],
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(14),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: Border.all(width: 1, color: AppColors.primary20),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About App',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          project.aboutProject,
                          textAlign: TextAlign.justify,
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'screens',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          addScreen(context, ref, project);
                        },
                        child: Container(
                          height: 30,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [AppColors.accent, AppColors.primary],
                            ),
                          ),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SearchBar(
                    onChanged: (value) =>
                        ref.read(searchProvider.notifier).state = value,
                    elevation: WidgetStateProperty.all(0),
                    backgroundColor: WidgetStateProperty.all(AppColors.card),
                    leading: const Icon(
                      Icons.search,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    hintText: 'search',
                    hintStyle: WidgetStateProperty.all(
                      TextStyle(color: AppColors.textPrimary.withOpacity(0.5)),
                    ),
                    controller: _searchController,
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppColors.primary20, width: 1),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: screens.isEmpty
                      ? const Center(child: Text('No screens found'))
                      : ListView.separated(
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 7),
                          itemCount: screens.length,
                          itemBuilder: (context, index) {
                            final screen = screens[index];

                            return InkWell(
                              onLongPress: () {
                                editdltAlert(context, ref, project, screen);
                              },
                              onTap: () {
                                log(
                                  'project id : ${widget.projectId} and screen id : ${screen.id}',
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailedScreen(
                                      projectId: widget.projectId,
                                      screenId: screen.id,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: AppColors.card,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    width: 1,
                                    color: AppColors.primary20,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Text(
                                          //   screen.screenName,
                                          //   style: const TextStyle(
                                          //     fontSize: 18,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
                                          Expanded(
                                            child: highlightedText(
                                              text: screen.screenName,
                                              query: searchText,
                                              normalStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.textPrimary,
                                              ),
                                              highlightStyle: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),

                                          Text(
                                            screen.status,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: statusColor(screen.status),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Text(screen.developerName),
                                      highlightedText(
                                        text: screen.developerName,
                                        query: searchText,
                                        normalStyle: const TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textPrimary,
                                        ),
                                        highlightStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget highlightedText({
  required String text,
  required String query,
  required TextStyle normalStyle,
  required TextStyle highlightStyle,
}) {
  if (query.isEmpty) {
    return Text(
      text,
      style: normalStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }

  final lowerText = text.toLowerCase();
  final lowerQuery = query.toLowerCase();

  if (!lowerText.startsWith(lowerQuery)) {
    return Text(
      text,
      style: normalStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
    );
  }

  return RichText(
    text: TextSpan(
      children: [
        TextSpan(text: text.substring(0, query.length), style: highlightStyle),
        TextSpan(text: text.substring(query.length), style: normalStyle),
      ],
    ),
  );
}

Color statusColor(String status) {
  log('color : $status');
  switch (status) {
    case 'Assigned':
      return Colors.blue;
    case 'Inprogress':
      return Colors.orange;
    case 'On Test':
      return Colors.deepPurple;
    case 'Completed':
      return AppColors.primary;
    case 'On Hold':
      return Colors.redAccent.shade200;
    default:
      return Colors.grey;
  }
}
