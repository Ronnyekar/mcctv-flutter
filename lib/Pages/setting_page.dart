import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// ignore: must_be_immutable
class SettingPage extends StatelessWidget {
  bool isSwitched = false;

  SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting Page"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(title: Text('Section 1'), tiles: [
            SettingsTile(
              title: Text('Language'),
              description: Text('English'),
              leading: const Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              initialValue: true,
              title: Text('Use System Theme'),
              leading: const Icon(Icons.phone_android),
              // switchValue: isSwitched,
              onToggle: (value) {
                // setState(() {
                //   isSwitched = value;
                // });
              },
            )
          ]),
          SettingsSection(
            margin: EdgeInsetsDirectional.all(20),
            // titlePadding: const EdgeInsets.all(20),
            title: Text('Section 2'),
            tiles: [
              SettingsTile(
                title: Text('Security'),
                description: Text('Fingerptint'),
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                initialValue: true,
                title: Text('Use Fingerprint'),
                leading: const Icon(Icons.fingerprint),
                // switchValue: true,
                onToggle: (value) {},
              )
            ],
          )
        ],
      ),
    );
  }
}
