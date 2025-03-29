import 'package:flutter/material.dart';
import 'package:app/viewmodels/user/user.viewmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _darkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: const Color(0xFF4A6FE5),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            children: [
              _buildSectionHeader('Account'),
              _buildProfileCard(),
              const SizedBox(height: 24),
              _buildSectionHeader('Preferences'),
              _buildSettingsCard([
                _buildSwitchTile(
                  'Notifications',
                  'Receive app notifications',
                  _notificationsEnabled,
                  (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
                const Divider(),
                _buildSwitchTile(
                  'Dark Mode',
                  'Use dark theme',
                  _darkModeEnabled,
                  (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
              ]),
              const SizedBox(height: 24),
              _buildSectionHeader('Support'),
              _buildSettingsCard([
                _buildTile('Help Center', 'Get help with using the app',
                    Icons.help_outline),
                const Divider(),
                _buildTile('Contact Us', 'Email or call our support team',
                    Icons.mail_outline),
                const Divider(),
                _buildTile('Send Feedback', 'Tell us how we can improve',
                    Icons.feedback_outlined),
              ]),
              const SizedBox(height: 24),
              _buildSectionHeader('About'),
              _buildSettingsCard([
                _buildTile(
                    'About This App', 'Version 1.0.0', Icons.info_outline),
                const Divider(),
                _buildTile('Terms of Service', 'Read our terms and conditions',
                    Icons.description_outlined),
                const Divider(),
                _buildTile('Privacy Policy', 'Learn how we handle your data',
                    Icons.privacy_tip_outlined),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF4A6FE5),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFF4A6FE5).withOpacity(0.1),
              child: const Icon(
                Icons.person,
                size: 30,
                color: Color(0xFF4A6FE5),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('john.doe@example.com',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(children: children),
      ),
    );
  }

  Widget _buildTile(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4A6FE5)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      value: value,
      activeColor: const Color(0xFF4A6FE5),
      onChanged: onChanged,
      secondary: Icon(
          value ? Icons.toggle_on_outlined : Icons.toggle_off_outlined,
          color: value ? const Color(0xFF4A6FE5) : Colors.grey),
    );
  }
}
