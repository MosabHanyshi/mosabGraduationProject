import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/general_state.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/user/user_cubit.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/ui/screens/chat_search.dart';
import 'package:mosabhhgraduationproject/ui/screens/profile_page.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved-left-shadow.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved-left.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved-right-shadow.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved-right.dart';
import 'package:mosabhhgraduationproject/ui/widgets/progressBar.dart';
import 'package:mosabhhgraduationproject/Methods/Methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool progressBarVisibility = false;
    bool textVisibility = true;
    double? maxWidth, maxHeight;
    double width = 60;
    double height = 60;
    double posY = 20;
    BorderRadiusGeometry borderRadius = BorderRadius.circular(30);
    @override
    void initState() {
      super.initState();
      maxWidth = MediaQuery.of(context).size.width;
      maxHeight = MediaQuery.of(context).size.height;
    }

    Future<void> manageTextVisibility() async {
      await Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          textVisibility = false;
          print(textVisibility);
        });
      });
    }

    Future<void> manageProgressBarVisibility() async {
      await Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          progressBarVisibility = true;
        });
      });
    }

    Future<void> manageContainerExpansion() async {
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          progressBarVisibility = false;
          borderRadius = BorderRadius.circular(0);
          width = size.width;
          height = size.height;
          posY = 0;
        });
      });
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          const Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
          const Positioned(top: 0, left: 0, child: CurvedLeft()),
          const Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
          const Positioned(bottom: 0, left: 0, child: CurvedRight()),
          SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    "Login",
                    style:
                        TextStyle(fontSize: 37.0, fontWeight: FontWeight.w700),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      padding: const EdgeInsets.only(left: 10.0),
                      margin: const EdgeInsets.only(right: 40.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20.0,
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(90.0),
                          bottomRight: Radius.circular(90.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            controller: emailController,
                            onChanged: (value) {
                              email = value;
                            },
                            style: const TextStyle(fontSize: 15.0),
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              icon: Icon(
                                Icons.person_outline,
                                size: 26.0,
                              ),
                              hintText: "Email",
                              border: InputBorder.none,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[200]!,
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: passwordController,
                            onChanged: (value) {
                              password = value;
                            },
                            style: const TextStyle(fontSize: 22.0),
                            obscureText: true,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                              ),
                              icon: Icon(
                                Icons.lock_outline,
                                size: 26.0,
                              ),
                              hintText: "Password",
                              border: InputBorder.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 10,
                      child: GestureDetector(
                        onTap: () async {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            setState(() {
                              showSpinner = true;
                            });

                            logIn(emailController.text, passwordController.text)
                                .then((user) {
                              if (user != null) {
                                print("Login Sucessfull");
                                setState(() {
                                  showSpinner = false;
                                });
                              } else {
                                print("Login Failed");
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            });
                          } else {
                            print("Please fill form correctly");
                          }
                          BlocProvider.of<UserCubit>(context)
                              .getCurrentUser(emailController.text,passwordController.text);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                AppColors.blue02,
                                AppColors.blue59,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                              )
                            ],
                          ),
                          child: BlocConsumer<UserCubit, GeneralState<User>>(
                              listener: (context, state) {
                            if (state is EmptyState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Enter Correct Email And Password')),
                              );
                            } else if (state is LoadedState) {
                              if ((state as LoadedState).data != null) {
                                Navigator.pushNamed(context, AppRoutes.home);
                              }
                            } else if (state is ErrorState) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //       content: Text(
                              //           'something went wrong please try again.')),
                              // );
                            }
                          }, builder: (context, state) {
                            if (state is LoadingState) {
                              // Show loading indicator
                              return CircularProgressIndicator();
                            } else if (state is LoadedState) {
                              return Icon(
                                Icons.check,
                                size: 40.0,
                                color: Colors.white,
                              );
                            } else if (state is ErrorState) {
                              return Icon(
                                Icons.arrow_forward,
                                size: 40.0,
                                color: Colors.white,
                              );
                            } else {
                              return Icon(
                                Icons.arrow_forward,
                                size: 40.0,
                                color: Colors.white,
                              );
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 25.0,
                //     horizontal: 30.0,
                //   ),
                //   child: Text(
                //     "Forgot?",
                //     style: TextStyle(
                //       fontSize: 22.0,
                //       color: Colors.grey[400],
                //       fontWeight: FontWeight.w700,
                //     ),
                //   ),
                // ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    top: 30.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Center(
          //       child: GestureDetector(
          //         child: AnimatedContainer(
          //           width: _width,
          //           height: _height,
          //           duration: const Duration(
          //             milliseconds: 10,
          //           ),
          //           child: Container(
          //             decoration: BoxDecoration(
          //               gradient: const LinearGradient(
          //                 begin: Alignment.centerLeft,
          //                 end: Alignment.centerRight,
          //                 colors: [
          //                   AppColors.blue02,
          //                   AppColors.blue59,
          //                 ],
          //               ),
          //               boxShadow: const [
          //                 BoxShadow(
          //                   color: Colors.black26,
          //                   blurRadius: 10.0,
          //                 )
          //               ],
          //               borderRadius: _borderRadius,
          //             ),
          //             child: Center(
          //               child: Stack(
          //                 children: [
          //                   Visibility(
          //                     visible: _textVisibility,
          //                     child: const Icon(
          //                       Icons.arrow_forward,
          //                       size: 40.0,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   Visibility(
          //                     child: CircularProgressIndicator(
          //                       backgroundColor: Colors.white,
          //                       strokeWidth: 1,
          //                     ),
          //                     visible: _progressBarVisibility,
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ),
          //         onTap: () {
          //           setState(() {
          //             if (_width == 60) {
          //               _width = 60;
          //             }
          //             print("object");
          //             _manageTextVisibility();
          //             _manageProgressBarVisibility();
          //             _manageContainerExpansion();
          //             // _manageSuccessTextVisibility();
          //             //_manageSuccessTextOpacity();
          //           });
          //         },
          //       ),
          //     ),
          //     SizedBox(width: _posY,)
          //   ],
          // )
        ],
      ),
    );
  }
}
