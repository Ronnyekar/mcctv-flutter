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
          SettingsSection(title: 'Section 1', tiles: [
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              leading: const Icon(Icons.language),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
              title: 'Use System Theme',
              leading: const Icon(Icons.phone_android),
              switchValue: isSwitched,
              onToggle: (value) {
                // setState(() {
                //   isSwitched = value;
                // });
              },
            )
          ]),
          SettingsSection(
            titlePadding: const EdgeInsets.all(20),
            title: 'Section 2',
            tiles: [
              SettingsTile(
                title: 'Security',
                subtitle: 'Fingerptint',
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use Fingerprint',
                leading: const Icon(Icons.fingerprint),
                switchValue: true,
                onToggle: (value) {},
              )
            ],
          )
        ],
      ),
    );
  }
}
