import "package:flutter/material.dart";
import "package:image_cropper/image_cropper.dart";
import "package:gallery_saver/gallery_saver.dart";


Future<String> CropImage(String photoPath,{bool? save}) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: photoPath,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.blue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      IOSUiSettings(
        title: 'Cropper',
      ),
    ],
  );

  if (croppedFile != null) {
    if (save == true) {
      await GallerySaver.saveImage(croppedFile.path);
      
    }
    return croppedFile.path;
  }

  return "";
}
