import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/user/user_cubit.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/data/sharedPrefrence/sharedP.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  User? currentUser;
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController repetedPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {
    SharedP().getCachedUser().then((user) {
      currentUser=user;
      currentUser?.pass="123123";
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget changePasswordButton = InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<UserCubit>(context)
              .updateUserPass(currentUser!.id!, newPass.text);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('password changed Successfully ')),
          );
          Navigator.pop(context);
        }
      },
      child: Container(
        height: 80,
        width: width / 1.5,
        decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Confirm Change",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Change My Password',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
            builder: (b, constraints) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 48.0, top: 16.0),
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                'Enter your current password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: TextFormField(
                                  controller: currentPass,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Existing Password',
                                      hintStyle: TextStyle(fontSize: 12.0)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else if (currentUser != null &&
                                        value != currentUser!.pass!) {
                                      return 'Please Enter Correct  Password';
                                    }
                                    return null;
                                  },
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 12.0),
                              child: Text(
                                'Enter new password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: TextFormField(
                                  controller: newPass,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'New Password',
                                      hintStyle: TextStyle(fontSize: 12.0)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 12.0),
                              child: Text(
                                'Retype new password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Retype Password',
                                      hintStyle: TextStyle(fontSize: 12.0)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    } else if (newPass.text.isNotEmpty &&
                                        value != newPass.text) {
                                      return 'Passwords dont Match';
                                    }
                                    return null;
                                  },
                                )),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 8.0,
                                bottom:
                                    bottomPadding != 20 ? 20 : bottomPadding),
                            width: width,
                            child: Center(child: changePasswordButton),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
