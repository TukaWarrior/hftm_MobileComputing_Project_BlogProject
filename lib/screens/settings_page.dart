import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Theme Mode"),
          const SizedBox(height: 8),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Slider(
                value: themeProvider.themeMode.index.toDouble(),
                min: 0,
                max: 2,
                divisions: 2,
                label: themeProvider.themeMode.toString().split('.').last,
                onChanged: (value) {
                  themeProvider.setThemeMode(ThemeMode.values[value.toInt()]);
                },
              );
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            title: const Text("Light"),
            leading: Radio(
              value: ThemeMode.light,
              groupValue: Provider.of<ThemeProvider>(context).themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  Provider.of<ThemeProvider>(context, listen: false).setThemeMode(value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text("Dark"),
            leading: Radio(
              value: ThemeMode.dark,
              groupValue: Provider.of<ThemeProvider>(context).themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  Provider.of<ThemeProvider>(context, listen: false).setThemeMode(value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text("System"),
            leading: Radio(
              value: ThemeMode.system,
              groupValue: Provider.of<ThemeProvider>(context).themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  Provider.of<ThemeProvider>(context, listen: false).setThemeMode(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
