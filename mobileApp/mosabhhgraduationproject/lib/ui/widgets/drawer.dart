
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mosabhhgraduationproject/config/route/app_routes.dart';
import 'package:mosabhhgraduationproject/config/theme/apperence.dart';
import 'package:mosabhhgraduationproject/config/theme/colors.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override

  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return  ClipRRect(
        borderRadius: const BorderRadius.only(
        topRight: Radius.circular(100),
    bottomRight: Radius.circular(100)),
      child: Drawer(
        elevation: 0,
        width: MediaQuery.of(context).size.width *0.65,
        child: Container(
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(
                height: 100,
                width: 100,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/imgs/logo1.png"),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    SizedBox(height: 16),

                   _buildListTile('Appearance', Icons.dark_mode, "", Colors.purple, theme, onTab: () => {
                   showModalBottomSheet<void>(
                   context: context,
                   builder: (BuildContext context) {
                     return _showAppearanceModal(theme,Appearance.DARK,context);
                   })
                   }),
                      // return Text(_.theme);

                    SizedBox(height: 8),
                    _buildListTile('Language', Icons.language, 'English', Colors.orange, theme, onTab: () {Navigator.pushNamed(context, AppRoutes.changeLanguage);}),
                    SizedBox(height: 8),
                    _buildListTile('Help', Icons.help, '', Colors.green, theme, onTab: () {}),
                    SizedBox(height: 8),
                    _buildListTile('Logout', Icons.exit_to_app, '', Colors.red, theme, onTab: () {}),
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
Widget _buildListTile(String title, IconData icon, String trailing, Color color, theme, {onTab}) {
  return ListTile(
      contentPadding: EdgeInsets.all(0),
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withAlpha(30)
        ),
        child: Center(
          child: Icon(icon, color: color,),
        ),
      ),
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Container(
        width: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.arrow_forward_ios, size: 12,),
          ],
        ),
      ),
      onTap: onTab
  );
}

_showAppearanceModal(ThemeData theme, Appearance current,BuildContext context) {

     return Container(
        padding: EdgeInsets.all(16),
        height: 320,
        decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select a Theme", style: theme.textTheme.subtitle1,),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.brightness_5, color: Colors.blue,),
              title: Text("Light", style: theme.textTheme.bodyText1),
              onTap: () {
                Navigator.pop(context);
              },
              trailing: Icon(Icons.check, color: current == Appearance.LIGHT ? AppColors.primaryBlue : Colors.transparent,),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.brightness_2, color: Colors.orange,),
              title: Text("Dark", style: theme.textTheme.bodyText1),
              onTap: () {
                Navigator.pop(context);
              },
              trailing: Icon(Icons.check, color: current == Appearance.DARK ? AppColors.primaryBlue : Colors.transparent,),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.brightness_6, color: Colors.blueGrey,),
              title: Text("System", style: theme.textTheme.bodyText1),
              onTap: () {
                Navigator.pop(context);
              },
              trailing: Icon(Icons.check, color: current == Appearance.SETTING? AppColors.primaryBlue : Colors.transparent,),
            ),
          ],
        ),
  );
}
