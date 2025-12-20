import 'package:bookreading/core/theme/app_colors.dart';
import 'package:bookreading/features/auth/presentation/widget/login_box.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back_ground_auth.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          LoginCard(),
        ],
      ),
    );
  }
}
