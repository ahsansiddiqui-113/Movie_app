import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Navigate to the settings screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Navigate to the about us screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                // Navigate to the help screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
