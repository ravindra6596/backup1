
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({ Key? key }) : super(key: key);

  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  
  File? imagePicked;
  void cameraImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      imagePicked = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void gallaryImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      imagePicked = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void removeImage() {
    setState(() {
      imagePicked = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 71,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 69,
              backgroundImage: imagePicked == null
                  ? null
                  : FileImage(
                      imagePicked!,
                    ),
            ),
          ),
        ),
        Positioned(
          left: 90,
          top: 90,
          child: RawMaterialButton(
            fillColor: Theme.of(context).backgroundColor,
            padding: EdgeInsets.all(10),
            shape: CircleBorder(),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Choose Option',
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: cameraImage,
                            label: Text(
                              'Camera',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            icon: Icon(
                              Icons.camera,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: gallaryImage,
                            label: Text(
                              'Gallery',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            icon: Icon(Icons.image),
                          ),
                          TextButton.icon(
                            onPressed: removeImage,
                            label: Text(
                              'Remove',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(
              Icons.add_a_photo,
            ),
          ),
        ),
      ],
    );
    
  }
}