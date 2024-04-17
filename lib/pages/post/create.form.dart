import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  final _globalKey = GlobalKey<FormState>();

  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _globalKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text, // Text input for name
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter name',
                labelText: 'Name',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number, // Number input for age
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'Enter age',
                labelText: 'Age',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.datetime, // Date input for last seen
              decoration: const InputDecoration(
                icon: Icon(Icons.access_time),
                hintText: 'Enter last seen',
                labelText: 'Last Seen',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number, // Number input for bounty
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: 'Enter bounty',
                labelText: 'Bounty (Reward)',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.image),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _uploadImage,
                    child: const Text("Upload Image"),
                  ),
                ],
              ),
            ),
            if (imageUrls.isNotEmpty)
              Column(
                children: imageUrls.map((imageUrl) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.network(
                      imageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            Container(
              margin: const EdgeInsets.only(top: 14.0),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(228, 151, 41, 1),
                  ),
                ), // You can add your button style here if needed
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xFile == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);
    try {
      await referenceImageToUpload.putFile(
        File(xFile.path),
        SettableMetadata(contentType: 'image/jpeg'),
      );
      String imageUrl = await referenceImageToUpload.getDownloadURL();

      setState(() {
        imageUrls.add(imageUrl);
      });
      
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }
}
