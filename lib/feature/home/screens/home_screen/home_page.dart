import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/auth/controller/auth_controllers.dart';
import 'package:to_do/feature/auth/screens/login.dart';
import 'package:to_do/feature/home/screens/about_project/about_project.dart';
import 'package:to_do/feature/home/controllers/home_controllers.dart';
import 'package:to_do/feature/home/model/home_model.dart';
import 'package:to_do/feature/home/screens/home_screen/add_project.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final detailsAsync = ref.watch(homelistProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,

              colors: AppColors.appBarGradient,
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'FlowState',
          style: TextStyle(
            color: Colors.white,
            // fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),

            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: AppColors.primary20,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Color.fromARGB(255, 160, 13, 3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );

              if (shouldLogout == true) {
                await ref.read(authProvider.notifier).logout();

                if (!context.mounted) return;

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: detailsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (details) {
            final pendingStatuses = {
              'Starting',
              'Inprogress',
              'Pending',
              'Onhold',
            };

            final pendingProjects = details
                .where((e) => pendingStatuses.contains(e.status))
                .toList();
            final completedProjects = details
                .where((e) => e.status == 'Completed')
                .toList();

            List<HomeModel> gridList;
            if (selectedFilter == 'Pending') {
              gridList = pendingProjects;
            } else if (selectedFilter == 'Completed') {
              gridList = completedProjects;
            } else {
              gridList = details;
            }

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: selectedFilter == 'Completed'
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.background, AppColors.primary10],
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.accent10, AppColors.primary10],
                          ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(width: 1, color: AppColors.primary20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        selectedFilter = 'Completed';
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Completed project',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          completedProjects.length.toString(),
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    gradient: selectedFilter == 'Pending'
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.background, AppColors.primary10],
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.accent10, AppColors.primary10],
                          ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(width: 1, color: AppColors.primary20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        selectedFilter = 'Pending';
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pending project',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          pendingProjects.length.toString(),
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    gradient: selectedFilter == 'all'
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.background, AppColors.primary10],
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.accent10, AppColors.primary10],
                          ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(width: 1, color: AppColors.primary20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        selectedFilter = 'all';
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total project',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          details.length.toString(),
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Projects',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      InkWell(
                        onTap: () => addProject(context, ref, null),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [AppColors.accent, AppColors.primary],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 30),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 150,
                    ),
                    itemCount: gridList.length,
                    itemBuilder: (context, index) {
                      log(
                        'starting date: ${details[index].startingDate.toString()}',
                      );
                      final project = gridList[index];
                      return InkWell(
                        onTap: () {
                          log('home page project id : ${project.id}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutProject(
                                projectId: project.id,
                                // projectData: project,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            border: Border.all(
                              width: 1,
                              color: AppColors.primary15,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // 'property managment',
                                project.projectName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Start date: ${project.startingDate}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textPrimary.withOpacity(
                                    0.65,
                                  ),
                                ),
                              ),
                              Text(
                                'Deadline : ${project.deadLine}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textPrimary.withOpacity(
                                    0.65,
                                  ),
                                ),
                              ),
                              Text(
                                project.endingDate.isEmpty
                                    ? 'End date: _'
                                    : 'End date: ${project.endingDate}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textPrimary.withOpacity(
                                    0.65,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      AppColors.accent,
                                      AppColors.primary,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    // 'COMPLETED',
                                    gridList[index].status,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
