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
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    _dateController.text = _formatDate(DateTime.now());
  }

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      onTap: _pickDate,
                      decoration: const InputDecoration(
                        labelText: 'Last Seen',
                      ),
                    ),
                  ),
                ],
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

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = _formatDate(pickedDate);
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
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
