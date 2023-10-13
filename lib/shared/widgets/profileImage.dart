import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final String image;
  final Function()? onPress;
  final double? size;

  const ProfileImage({super.key, required this.image, this.size, this.onPress});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? loadedImage;
  bool loading = false;

  Future<File?> getImage() async {
    var loadImage = File(widget.image);

    if (await loadImage.exists()) {
      return loadImage;
    }

    return null;
  }

  Future<void> setImage() async {
    setState(() {
      loading = true;
    });

    var image = await getImage();

    setState(() {
      loading = false;
      loadedImage = image;
    });
  }

  @override
  void initState() {
    setImage();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProfileImage oldWidget) {
    setImage();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size ?? 60,
        height: widget.size ?? 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.size ?? 60)),
        child: !loading
            ? InkWell(
                borderRadius: BorderRadius.circular(widget.size ?? 60),
                onTap: widget.onPress,
                child: loadedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(widget.size ?? 60),
                        child: Image.file(
                          loadedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(Icons.account_circle, size: widget.size ?? 60))
            : const CircularProgressIndicator());
  }
}
