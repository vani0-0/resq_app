import 'package:flutter/material.dart';

class CreateForm extends StatefulWidget {
  const CreateForm({super.key});

  @override
  State<CreateForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateForm> {
  final _globalKey = GlobalKey<FormState>();

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
            Row(
              children: [
                const Icon(Icons.image), // Icon for image attachment
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    keyboardType:
                        TextInputType.url, // URL input for image attachment
                    decoration: const InputDecoration(
                      hintText: 'Attach image URL',
                      labelText: 'Picture / Image',
                    ),
                  ),
                ),
              ],
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
}
