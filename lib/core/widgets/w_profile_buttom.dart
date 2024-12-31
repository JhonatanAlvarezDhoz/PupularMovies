import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback onTap;
  const ProfileButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: onTap,
        child: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.jpeg"),
        ),
      ),
    );
  }
}
