import 'dart:io';
import 'package:med_app/constants.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionWidget extends StatefulWidget {
  final TextEditingController imageUrlController; // Add this line

  const ImageSelectionWidget({Key? key, required this.imageUrlController})
      : super(key: key); // Update constructor

  @override
  State<ImageSelectionWidget> createState() => _ImageSelectionWidgetState();
}

class _ImageSelectionWidgetState extends State<ImageSelectionWidget> {
  late File _image;
  late String _url;
  bool showError = true; // New variable to track error message visibility

  @override
  void initState() {
    _image = File('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 120,
              child: Stack(
                children: <Widget>[
                  // _image != null &&
                  _image.path.isNotEmpty
                      ? Image.file(
                          _image,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Color.fromARGB(255, 222, 222, 222),
                          child: Center(child: Text("No image")),
                        ),
                ],
              ),
            ),
            GestureDetector(
              onTap: pickImage,
              child: Icon(Icons.camera_alt),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(
              builder: (context) => ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor)),
                onPressed: () {
                  if (_image.path.isEmpty) {
                    setState(() {
                      showError = true;
                    });
                  } else {
                    // Image selected, perform upload
                    uploadImage(context);
                  }
                },
                child: Text('Upload Image'),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        showError
            ? Text(
                'Please select an image',
                style: TextStyle(color: Colors.red),
              )
            : SizedBox(), // Error message
      ],
    );
  }

  void pickImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
        showError = false;
      });
    }
  }

 void uploadImage(BuildContext context) async {
  // Create a unique filename for the uploaded image
  String fileName = p.basename(_image.path);

  // Create a reference to the Firebase Storage location
  Reference storageReference =
      FirebaseStorage.instance.ref().child('images/$fileName');

  // Upload the file to the specified location
  UploadTask uploadTask = storageReference.putFile(_image);

  // Show a circular progress indicator while uploading
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Uploading Image'),
        content: CircularProgressIndicator(), // Circular spinner
      );
    },
  );

  // Monitor the upload process
  uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
    if (snapshot.state == TaskState.success) {
      // Upload completed successfully
      storageReference.getDownloadURL().then((fileUrl) {
        setState(() {
          _url = fileUrl;
        });
        widget.imageUrlController.text = fileUrl; // Set the imageUrl value

        // Use the fileUrl as needed (e.g., save to database, display the image)
        print('Download URL: $_url');

        Navigator.of(context).pop(); // Close the progress dialog

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Image uploaded successfully'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      });
    } else if (snapshot.state == TaskState.error) {
      // Error occurred during upload
      Navigator.of(context).pop(); // Close the progress dialog

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed to upload image'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  });
}
}
