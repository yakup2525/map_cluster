import 'package:flutter/material.dart';

import '/core/core.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.7), // Dairenin rengi
        shape: BoxShape.circle, // Daire şekli
      ),
      height: 100,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(user.profilePic),
        ),
      ),
    );
  }
}
