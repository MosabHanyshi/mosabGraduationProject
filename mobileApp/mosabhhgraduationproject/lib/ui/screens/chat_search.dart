import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/ui/screens/chat_room.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';
import 'package:flutter/material.dart' show Icon, Color;

class HomeScreenChat extends StatefulWidget {
  @override
  const HomeScreenChat({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenChat>
    with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.yellow95.withOpacity(0.7),
        title: Row(
          children: [
            Image.asset('assets/images/logo1.png', height: 25),
            SizedBox(width: 10),
            Text('Chats'),
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.8),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
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
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: const CircleAvatar(
                              radius: 300,
                              backgroundColor:
                                  Color.fromARGB(255, 251, 240, 227),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/search2.png')),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
    );
  }
}
