import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sectionBackgroundColor =
        Color.lerp(theme.colorScheme.surface, Colors.white, 0.1)!;
    final dividerColor =
        Color.lerp(theme.colorScheme.surface, Colors.white, 0.3)!;
    final dangerousColor =
        Color.lerp(theme.colorScheme.error, Colors.white, 0.2)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  const Center(
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Notification and About Section
              Material(
                child: Ink(
                  decoration: BoxDecoration(
                    color: sectionBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: const Icon(Icons.notifications),
                        title: const Text("Notifications"),
                        trailing: Switch(
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              checked = value;
                            });
                          },
                        ),
                        onTap: null,
                      ),
                      _divider(dividerColor),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: const Icon(Icons.info),
                        title: const Text("About"),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Material(
                child: Ink(
                  decoration: BoxDecoration(
                    color: sectionBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: Icon(
                          Icons.logout,
                          color: dangerousColor,
                        ),
                        title: Text(
                          "Log Out",
                          style: TextStyle(color: dangerousColor),
                        ),
                        onTap: () {},
                      ),
                      _divider(dividerColor),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: Icon(
                          Icons.delete,
                          color: dangerousColor,
                        ),
                        title: Text(
                          "Delete Account",
                          style: TextStyle(color: dangerousColor),
                        ),
                        onTap: () {
                          // Handle account deletion action
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Divider(height: 1, color: color),
    );
  }
}
