import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:mosabhhgraduationproject/data/model/user.dart';
import 'package:mosabhhgraduationproject/data/sharedPrefrence/sharedP.dart';
import 'package:mosabhhgraduationproject/ui/screens/chat_room.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser;

  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth.FirebaseAuth _auth = FirebaseAuth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {
    SharedP().getCachedUser().then((user) {
      setState(() {
        currentUser = user;
      });
    }, onError: (error) {});
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore
        .collection('users')
        .where("email", isEqualTo: 'bot@gmail.com')
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                // const CircleAvatar(
                //   maxRadius: 48,
                //   backgroundImage: AssetImage('assets/background.jpg'),
                // ),
                Container(
                  width: 100.0,
                  height: 100.0,
                  child: ClipOval(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: currentUser?.pic != null
                        ? Image.file(
                            File(currentUser!.pic!),
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/person.jpg",
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${currentUser?.fullName}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primaryBlue,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset(
                                'assets/images/location_icon.png',
                                height: 30,
                                width: 30,
                              ),
                              onPressed: () => {
                                Navigator.pushNamed(
                                    context, AppRoutes.addNewAddress)
                              },
                            ),
                            Text(
                              'Address',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/images/card.png'),
                              onPressed: () => {
                                Navigator.pushNamed(context, AppRoutes.cardList)
                              },
                            ),
                            Text(
                              'My Cards',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset(
                                'assets/images/chat_icon.png',
                                height: 30,
                                width: 30,
                              ),
                              onPressed: () async {
                                try {
                                  onSearch();
                                  String roomId = chatRoomId(
                                      _auth.currentUser!.displayName!,
                                      userMap!['email']);

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ChatRoom(
                                        chatRoomId: roomId,
                                        userMap: userMap!,
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  print(e);
                                }
                              },
                            ),
                            Text(
                              'My Messages',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: SvgPicture.asset(
                                  'assets/images/profile_icon.svg'),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.editProfile);
                              },
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Password'),
                  subtitle: Text('Change My Password'),
                  leading: Image.asset(
                    'assets/images/lock.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing:
                      Icon(Icons.chevron_right, color: AppColors.primaryBlue),
                  onTap: () =>
                      {Navigator.pushNamed(context, AppRoutes.changePassword)},
                ),
                Divider(),
                ListTile(
                  title: Text('Help Center'),
                  subtitle: Text('ask us'),
                  leading: Icon(
                    Icons.help,
                    color: Colors.black,
                    size: 30,
                  ),
                  trailing:
                      Icon(Icons.chevron_right, color: AppColors.primaryBlue),
                  onTap: () => {},
                ),
                Divider(),
                ListTile(
                  title: Text('log out'),
                  subtitle: Text('have safe trip'),
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                    size: 30,
                  ),
                  trailing:
                      Icon(Icons.chevron_right, color: AppColors.primaryBlue),
                  onTap: () {
                    SharedP().clearPrefrense();
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, (r) => false);
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
