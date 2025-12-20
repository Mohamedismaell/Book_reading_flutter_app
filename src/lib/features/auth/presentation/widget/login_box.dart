import 'dart:ui';
import 'package:bookreading/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.aboveGround.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: _content(),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Email",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: () {}, child: const Text("Continue")),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Forgot password?",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
