import 'package:chai/app/widgets/toasts.dart';
import 'package:chai/controllers/auth.dart';
import 'package:chai/repository/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  bool notificationChecked = false;
  bool soundChecked = false;

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
              Consumer(
                builder: (context, ref, child) {
                  final user = ref.watch(currentUserProvider);
                  return user.maybeWhen(
                    data: (u) => Column(
                      children: [
                        _UserProfile(
                          email: u.email,
                          fullName: u.name,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
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
                          value: notificationChecked,
                          onChanged: (bool value) {
                            setState(() {
                              notificationChecked = value;
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
                        leading: const Icon(Icons.music_note),
                        title: const Text("Sound"),
                        trailing: Switch(
                          value: soundChecked,
                          onChanged: (bool value) {
                            setState(() {
                              soundChecked = value;
                            });
                          },
                        ),
                        onTap: null,
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
                        leading: const Icon(Icons.privacy_tip),
                        title: const Text("Privacy"),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          launchUrlString('https://chai-solutions.org/privacy');
                        },
                      ),
                      _divider(dividerColor),
                      ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        leading: const Icon(Icons.info),
                        title: const Text("About"),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          context.push('/about');
                        },
                      ),
                      _divider(dividerColor),
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
                        onTap: () async {
                          final authController =
                              ref.read(authControllerProvider.notifier);
                          await authController.logout();

                          if (context.mounted) {
                            infoToast(
                              context: context,
                              title: 'Logged Out',
                              message: 'Come back soon!',
                              icon: const Icon(Icons.logout),
                            );
                            context.replace('/login');
                          }
                        },
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

class _UserProfile extends StatelessWidget {
  final String fullName;
  final String email;

  const _UserProfile({
    required this.fullName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final component = Uri.encodeComponent(fullName);
    final imageUrl = "https://ui-avatars.com/api/?name=$component";

    final theme = Theme.of(context);
    final sectionBackgroundColor =
        Color.lerp(theme.colorScheme.surface, Colors.white, 0.1)!;
    final emailColor =
        Color.lerp(theme.colorScheme.onSurface, Colors.black, 0.4)!;

    return Container(
      decoration: BoxDecoration(
        color: sectionBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(width: 16),

            // Name and Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 14,
                    color: emailColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
