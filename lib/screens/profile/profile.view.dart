import 'package:flutter/material.dart';
import 'package:app/extenstions/user.ext.dart';
import 'package:app/global/textfield.widet.dart';
import 'package:app/services/storage/storage.service.dart';
import 'package:app/viewmodels/user/user.viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF4A6FE5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          children: [
            _buildProfileCard(context),
            const SizedBox(height: 24),
            _buildSectionHeader('Account Information'),
            _buildSettingsCard([
              _buildTile(
                'Full Name',
                "${context.user!.firstName} ${context.user!.lastName}",
                Icons.person_outline,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (e) => const EditNameView()));
                },
              ),
              const Divider(),
              _buildTile(
                'Email',
                context.user!.email,
                Icons.email_outlined,
                onTap: () {},
              ),
              const Divider(),
              _buildTile(
                'Password',
                'Change your password',
                Icons.lock_outline,
                onTap: () {},
              ),
              const Divider(),
              _buildTile(
                'Add Account',
                'Add a new account',
                Icons.add_circle_outline,
                onTap: () {
                  // Navigate to the Add Account screen or show a dialog
                  _showAddAccountDialog(context);
                },
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('Activity'),
            _buildSettingsCard([
              _buildTile(
                'History',
                'View your past activities',
                Icons.history_outlined,
                onTap: () {},
              ),
              const Divider(),
              _buildTile(
                'Manage Access',
                'Control app permissions',
                Icons.admin_panel_settings_outlined,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionHeader('Account'),
            _buildSettingsCard([
              _buildTile(
                'Manage Account',
                'Update your account settings',
                Icons.settings_outlined,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 32),
            _buildLogoutButton(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Function to show the Add Account dialog
  void _showAddAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Account'),
          content: const Text('Enter the details of the new account.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                // Logic to add the new account
                // You can navigate to a new screen or perform the addition here
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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

  Widget _buildProfileCard(BuildContext context) {
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
                children: [
                  Text(
                    "Hello ${context.user!.firstName} 👋",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.user!.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
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

  Widget _buildTile(String title, String subtitle, IconData icon,
      {required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4A6FE5)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () {
          SecureStorageService().delete('access_token');
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.logout_outlined,
                color: Colors.redAccent,
              ),
              SizedBox(width: 8),
              Text(
                "Log Out",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditNameView extends StatefulWidget {
  const EditNameView({super.key});

  @override
  State<EditNameView> createState() => _EditNameViewState();
}

class _EditNameViewState extends State<EditNameView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      firstNameController.text = context.read<UserViewModel>().user!.firstName;
      lastNameController.text = context.read<UserViewModel>().user!.lastName;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Name'),
        backgroundColor: const Color(0xFF4A6FE5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                CareBloomField(
                  label: 'First Name',
                  placeholder: 'Eg. John',
                  controller: firstNameController,
                ),
                CareBloomField(
                  label: 'Last Name',
                  placeholder: 'Eg. Doe',
                  controller: lastNameController,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<UserViewModel>().changeName(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          onSuccess: () {
                            Navigator.pop(context);
                          },
                          onError: () {
                            // toast
                          });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A6FE5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: context.watch<UserViewModel>().isEditingUser
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Update Info',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
