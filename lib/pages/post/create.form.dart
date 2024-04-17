import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hanap_app/models/models.dart';
import 'package:hanap_app/services/database_service.dart';
import 'package:image_picker/image_picker.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  final DatabaseService _dbService = DatabaseService();
  final _globalKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _bountyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
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
              keyboardType: TextInputType.text,
              controller: _nameController,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter name',
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'Enter age',
                labelText: 'Age',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter age';
                }
                return null;
              },
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
              keyboardType: TextInputType.number,
              controller: _bountyController,
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: 'Enter bounty',
                labelText: 'Bounty (Reward)',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter bounty';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: _descriptionController,
              maxLines: null,
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                hintText: 'Enter description',
                labelText: 'Description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please add more description';
                }
                return null;
              },
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
                onPressed: _submitForm,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(228, 151, 41, 1),
                  ),
                ),
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

  void _submitForm() {
    if (_globalKey.currentState!.validate()) {
      String name = _nameController.text;
      int age = int.tryParse(_ageController.text) ?? 0;
      String description = _descriptionController.text;
      int bounty = int.tryParse(_bountyController.text) ?? 0;

      // Ensure that _selectedDate is not null before using it
      DateTime? lastSeen = _selectedDate ?? DateTime.now();

      Content newData = Content(
        name: name,
        age: age,
        description: description,
        bounty: bounty,
        lastSeen: lastSeen,
        imageUrls: imageUrls,
      );
      _dbService.addMissing(newData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
    return;
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
