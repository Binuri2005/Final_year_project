import 'package:app/extenstions/user.ext.dart';
import 'package:app/global/textfield.widet.dart';
import 'package:app/services/storage/storage.service.dart';
import 'package:app/viewmodels/user/user.viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            SizedBox(height: 30),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  radius: 40,
                  child: Icon(
                    Iconsax.user_bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Hello ${context.user!.firstName} 👋",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 30),
            ProfileSection(
              items: [
                ProfileItem(
                  title: 'Full Name',
                  value: "${context.user!.firstName} ${context.user!.lastName}",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (e) => EditNameView()));
                  },
                ),
                ProfileItem(
                  title: 'Email',
                  value: context.user!.email,
                  onTap: () {},
                ),
                ProfileItem(
                  title: 'Password',
                  value: null,
                  showDivider: false,
                  onTap: () {},
                )
              ],
            ),
            ProfileSection(
              items: [
                ProfileItem(
                  title: 'Leaderboard',
                  onTap: () {},
                ),
                ProfileItem(
                  title: 'History',
                  onTap: () {},
                ),
                ProfileItem(
                  title: 'Manage Access',
                  value: null,
                  showDivider: false,
                  onTap: () {},
                )
              ],
            ),
            ProfileSection(
              items: [
                ProfileItem(
                  title: 'Manage Account',
                  onTap: () {},
                  showDivider: false,
                ),
              ],
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                SecureStorageService().delete('access_token');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.logout_1_bold,
                    color: Colors.redAccent,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Log Out",
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final List<ProfileItem> items;
  const ProfileSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withOpacity(0.2))),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(children: items),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String title;
  final String? value;

  final VoidCallback onTap;

  final bool showDivider;

  const ProfileItem({
    super.key,
    required this.title,
    this.value,
    this.showDivider = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      child: value != null
                          ? Text(
                              value!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black.withOpacity(0.7),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_sharp,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
            Column(
              children: showDivider
                  ? [
                      SizedBox(height: 5),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      SizedBox(height: 5),
                    ]
                  : [],
            )
          ],
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
        title: Text("Change Name"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
              SizedBox(height: 20),
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
                          //   toast
                        });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 51, 155, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  child: context.watch<UserViewModel>().isEditingUser
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Update Info',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
