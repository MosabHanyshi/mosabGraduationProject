import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosabhhgraduationproject/Methods/Methods.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/user/user_cubit.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/ui/screens/log_in.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved-left-shadow.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved-left.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved-right-shadow.dart';
import 'package:mosabhhgraduationproject/ui/widgets/curved-right.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              const Positioned(top: 0, left: 0, child: CurvedLeftShadow()),
              const Positioned(top: 0, left: 0, child: CurvedLeft()),
              const Positioned(bottom: 0, left: 0, child: CurvedRightShadow()),
              const Positioned(bottom: 0, left: 0, child: CurvedRight()),
              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(
                          right: 30.0, top: 160.0, bottom: 50.0),
                      child: InkWell(
                        onTap: () =>
                            {Navigator.pushNamed(context, AppRoutes.login)},
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 55.0),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 37.0, fontWeight: FontWeight.w700),
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
                                style: const TextStyle(fontSize: 16.0),
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0,
                                  ),
                                  icon: Icon(
                                    Icons.alternate_email,
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
                                style: const TextStyle(fontSize: 18.0),
                                controller: passwordController,
                                obscureText: true,
                                onChanged: (value) {
                                  password = value;
                                },
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
                          top: 50,
                          right: 10,
                          child: GestureDetector(
                            onTap: () async {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                setState(() {
                                  showSpinner = true;
                                });
                                createAccount(emailController.text,
                                    passwordController.text);
                                BlocProvider.of<UserCubit>(context)
                                    .addUser(User(
                                        id: Random().nextInt(1000000000),
                                        pass: passwordController.text,
                                        email: emailController.text))
                                    .then((user) {
                                  setState(() {
                                    showSpinner = false;
                                  });
                                  Navigator.pushNamed(context, AppRoutes.login);

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (_) => firstWithFireBase()));
                                  print("Account Created Sucessfull");
                                });
                              } else {
                                print("Please enter Fields");
                              }
                            },
                            child: Stack(children: [
                              Visibility(
                                child: Container(
                                  padding: const EdgeInsets.all(15.0),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color.fromRGBO(94, 201, 202, 1.0),
                                        Color.fromRGBO(119, 235, 159, 1.0),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10.0,
                                      )
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 40.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
