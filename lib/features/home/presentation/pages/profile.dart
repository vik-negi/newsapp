import 'package:flutter/material.dart';
import 'package:news/features/auth/presentation/provider/auth_provider.dart';
import 'package:news/features/home/presentation/providers/news_provider.dart';
import 'package:news/resourses/r.dart';
import 'package:news/utils/constants.dart';
import 'package:news/utils/cw_text.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<LocalAuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: CWText(
          text: 'My Profile',
          color: R.color.white,
          fontSize: 16,
        ),
        backgroundColor: R.color.myBlue,
        automaticallyImplyLeading: false,
        foregroundColor: R.color.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  user?.displayName?.substring(0, 1).toUpperCase() ?? '',
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CWText(
              text: user?.displayName ?? '',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 10),
            CWText(
              text: user?.email ?? '',
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<LocalAuthProvider>().logout();
                  context.read<NewsProvider>().reset();
                  Navigator.pushReplacementNamed(context, Constants.login);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
