import 'package:flutter/material.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg1.jpg'), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              controller: controller,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bg1.jpg'),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'Get Any Thing Online',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),

                      Center(
                        child: Image.asset(
                          'assets/images/first_screen.png',
                          height: 200,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 32, vertical: 30.0),
                        child: Text(
                          'You can buy anything ranging from digital products to hardware within few clicks.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bg2.jpg'),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Image.asset(
                          'assets/images/sec_screen.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32,vertical: 10),
                        child: Text(
                          'Easy & Safe Payment ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                        child: Text(
                          'Easy checkout and Safe payment method , Trusted by all our customers.',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/bg3.jpg'),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Image.asset(
                          'assets/imgs/third_screen.png',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Fast delivery',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16.0),
                        child: Text(
                          'Reliable and Fast Delivery. We deliver your product the fastest way possible .',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color: pageIndex == 0
                                  ? AppColors.yellow
                                  : Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color: pageIndex == 1
                                  ? AppColors.yellow
                                  : Colors.white),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black, width: 2),
                              color: pageIndex == 2
                                  ? AppColors.yellow
                                  : Colors.white),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Opacity(
                          opacity: pageIndex != 2 ? 1.0 : 0.0,
                          child: TextButton(
                            child: const Text(
                              'SKIP',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.home);
                            },
                          ),
                        ),
                        pageIndex != 2
                            ? TextButton(
                                child: const Text(
                                  'NEXT',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  if (!(controller.page == 2.0)) {
                                    controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                  }
                                },
                              )
                            : TextButton(
                                child: const Text(
                                  'FINISH',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.home);
                                },
                              )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
