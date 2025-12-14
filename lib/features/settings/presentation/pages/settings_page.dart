import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _dailyReminders = true;
  bool _weeklyProgress = true;
  bool _darkMode = false;

  void _onItemTapped(BuildContext context, String title) {}

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF3B82F6);
    const Color lightBackground = Color(0xFFF3F5F9);
    const Color darkText = Color(0xFF1A252F);
    const Color greyText = Color(0xFF5A6B7B);

    return Scaffold(
      backgroundColor: lightBackground,
      // 1. AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      // 2. Body
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _SettingsGroup(
                    title: 'General',
                    children: [
                      _SettingsItem(
                        icon: Icons.language_outlined,
                        title: 'Language',
                        value: 'English',
                        onTap: () => _onItemTapped(context, 'Language'),
                      ),
                      SwitchListTile(
                        secondary: const Icon(Icons.dark_mode_outlined, color: greyText),
                        title: const Text(
                          'Dark Mode',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        value: _darkMode,
                        onChanged: (bool value) {
                          setState(() {
                            _darkMode = value;
                          });
                        },
                        activeColor: primaryBlue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- Section: Notifications ---
                  _SettingsGroup(
                    title: 'Notifications',
                    children: [
                      SwitchListTile(
                        secondary: const Icon(Icons.notifications_active_outlined, color: greyText),
                        title: const Text(
                          'Daily Reminders',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Remind me to practice every day'),
                        value: _dailyReminders,
                        onChanged: (bool value) {
                          setState(() {
                            _dailyReminders = value;
                          });
                        },
                        activeColor: primaryBlue,
                      ),
                      const Divider(height: 1, indent: 72),
                      SwitchListTile(
                        secondary: const Icon(Icons.assessment_outlined, color: greyText),
                        title: const Text(
                          'Weekly Progress Report',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        subtitle: const Text('Send a summary of my learning'),
                        value: _weeklyProgress,
                        onChanged: (bool value) {
                          setState(() {
                            _weeklyProgress = value;
                          });
                        },
                        activeColor: primaryBlue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _SettingsGroup(
                    title: 'Support & About',
                    children: [
                      _SettingsItem(
                        icon: Icons.help_outline,
                        title: 'Help & FAQ',
                        onTap: () => _onItemTapped(context, 'Help & FAQ'),
                      ),
                      _SettingsItem(
                        icon: Icons.description_outlined,
                        title: 'Terms of Service',
                        onTap: () => _onItemTapped(context, 'Terms of Service'),
                      ),
                      _SettingsItem(
                        icon: Icons.shield_outlined,
                        title: 'Privacy Policy',
                        onTap: () => _onItemTapped(context, 'Privacy Policy'),
                      ),
                      _SettingsItem(
                        icon: Icons.info_outline,
                        title: 'About Magic English',
                        value: 'v1.0.0',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: Color(0xFF5A6B7B),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    const Color greyText = Color(0xFF5A6B7B);
    const Color darkText = Color(0xFF1A252F);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          child: Row(
            children: [
              Icon(icon, color: greyText, size: 24),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: darkText,
                  ),
                ),
              ),
              if (value != null)
                Text(
                  value!,
                  style: const TextStyle(fontSize: 16, color: greyText),
                ),
              const SizedBox(width: 8),
              if (value == null)
                const Icon(Icons.chevron_right, color: Colors.grey, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
