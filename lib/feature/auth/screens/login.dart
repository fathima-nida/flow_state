// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:to_do/core/constant/asset_resource.dart';
// import 'package:to_do/core/theme/app_colors.dart';
// import 'package:to_do/feature/home/screens/home_screen/home_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController emailCntlr = TextEditingController();
//   TextEditingController pswrdCtlr = TextEditingController();

//   bool showPassword = false;

//   final formkey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     loginCheker();
//   }

//   Future<void> loginCheker() async {
//     final prefs = await SharedPreferences.getInstance();
//     final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

//     if (isLoggedIn) {
//       // WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => HomePage()),
//         );
//       // });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Form(
//             key: formkey,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset(AssetResource.logo, width: 400, height: 60),
//                   SizedBox(height: 50),
//                   TextFormField(
//                     textInputAction: TextInputAction.next,
//                     keyboardType: TextInputType.emailAddress,
//                     controller: emailCntlr,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your Email';
//                       }
//                       if (!value.contains('@')) {
//                         return 'Please enter a valid Email';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       labelStyle: TextStyle(color: AppColors.primary),

//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: AppColors.primary,
//                           width: 1.5,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: AppColors.primary,
//                           width: 1.5,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: AppColors.primary,
//                           width: 2,
//                         ),
//                       ),
//                       prefixIcon: Icon(Icons.email, color: AppColors.primary),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     textInputAction: TextInputAction.done,
//                     controller: pswrdCtlr,
//                     obscureText: !showPassword,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your PassWord!';
//                       }

//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       label: Text('password'),
//                       labelStyle: TextStyle(color: AppColors.primary),

//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: AppColors.primary,
//                           width: 1.5,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: AppColors.primary,
//                           width: 1.5,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           color: AppColors.primary,
//                           width: 2,
//                         ),
//                       ),
//                       prefixIcon: Icon(
//                         Icons.lock_outline,
//                         color: AppColors.primary,
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           showPassword
//                               ? Icons.visibility_outlined
//                               : Icons.visibility_off_outlined,

//                           color: AppColors.primary,
//                         ),

//                         onPressed: () {
//                           setState(() {
//                             showPassword = !showPassword;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 100),
//                   InkWell(
//                     onTap: () async {
//                       if (formkey.currentState!.validate()) {
//                         final prefs = await SharedPreferences.getInstance();
//                         await prefs.setBool('isLoggedIn', true);
//                         await prefs.setString('email', emailCntlr.text.trim());

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text(
//                               'Login successfully',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             backgroundColor: Colors.black45,
//                           ),
//                         );

//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (_) => HomePage()),
//                         );
//                       }
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: 50,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: LinearGradient(
//                           colors: AppColors.appBarGradient,
//                         ),
//                       ),
//                       child: Text(
//                         'login',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/core/constant/asset_resource.dart';
import 'package:to_do/core/theme/app_colors.dart';
import 'package:to_do/feature/auth/controller/auth_controllers.dart';
import 'package:to_do/feature/home/screens/home_screen/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  TextEditingController emailCntlr = TextEditingController();
  TextEditingController pswrdCtlr = TextEditingController();

  bool showPassword = false;
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailCntlr.dispose();
    pswrdCtlr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetResource.logo, width: 400, height: 60),

                  SizedBox(height: 50),

                  /// EMAIL
                  TextFormField(
                    controller: emailCntlr,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: AppColors.primary),
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
                      prefixIcon: Icon(Icons.email, color: AppColors.primary),
                    ),
                  ),

                  SizedBox(height: 20),

                  /// PASSWORD
                  TextFormField(
                    controller: pswrdCtlr,
                    obscureText: !showPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: AppColors.primary),
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
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 80),

                  /// LOGIN BUTTON
                  InkWell(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        await ref
                            .read(authProvider.notifier)
                            .login(emailCntlr.text.trim());

                        final authState = ref.read(authProvider);

                        if (!mounted) return;

                        authState.when(
                          data: (loggedIn) {
                            if (loggedIn) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => HomePage()),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login successfully')),
                              );
                            }
                          },
                          loading: () {},
                          error: (e, st) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login failed')),
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: AppColors.appBarGradient,
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
