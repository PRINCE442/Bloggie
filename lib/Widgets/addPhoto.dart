import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _pickedImageFile;

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 450,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 100,
      backgroundColor: Colors.lightBlue.shade300,
      child: CircleAvatar(
        backgroundImage:
            _pickedImageFile != null ? FileImage(_pickedImageFile!) : null,
        radius: 100,
        child: _pickedImageFile == null
            ? Column(
                children: [
                  IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(
                      Icons.add_a_photo_sharp,
                      size: 33,
                    ),
                  ),
                  const Text(
                    'Add Photo',
                    style: TextStyle(fontSize: 11),
                  )
                ],
              )
            : null,
      ),
    );
  }
}
