import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagepicker extends StatefulWidget {
  UserImagepicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagepickerState createState() => _UserImagepickerState();
}

class _UserImagepickerState extends State<UserImagepicker> {
  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker.pickImage(
      //upload a small image
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    //forward pick image file
    widget.imagePickFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add image'),
        ),
      ],
    );
  }
}
