import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final String imagePath;
  final Function() onPress;

  const ProfileImage({super.key, required this.imagePath,required this.onPress});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPress,
      child: widget.imagePath.isNotEmpty
          ? Image.file(File(widget.imagePath))
          : const Icon(Icons.account_circle),
    );
  }
}
