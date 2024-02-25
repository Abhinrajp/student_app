import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentapp_new/database/database_functions.dart';
import 'package:studentapp_new/models/model.dart';

class ScreenForm extends StatefulWidget {
  const ScreenForm({super.key});

  @override
  State<ScreenForm> createState() => _HomeScreenState();
}

final formKey = GlobalKey<FormState>();

class _HomeScreenState extends State<ScreenForm> {
  XFile? image;
  var nameControll = TextEditingController();
  final ageControll = TextEditingController();
  final placeControll = TextEditingController();
  final admControll = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter the details'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      image != null
                          ? CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(File(image!.path)),
                            )
                          : const CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  AssetImage("lib/assets/user-not-found.png"),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 80,
                        ),
                        child: IconButton(
                            color: const Color.fromARGB(255, 146, 145, 145),
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              var image1 = await picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                image = image1;
                              });
                            },
                            icon: const Icon(
                              Icons.camera_alt_rounded,
                              size: 40,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Enter name'
                            : null,
                        controller: nameControll,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              width: 3.0,
                            ),
                          ),
                          hintText: 'name',
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Enter Age'
                            : null,
                        controller: ageControll,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              width: 1.0,
                            ),
                          ),
                          hintText: 'age',
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Enter Place'
                            : null,
                        controller: placeControll,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Place',
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Enter Addmission number'
                            : null,
                        controller: admControll,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Addmission number',
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate() &&
                              image != null) {
                            await addStudButt();
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      'Submited successfully',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    )));
                          } else if (image == null) {
                            noImage();
                          }
                        },
                        icon: const Icon(Icons.upload),
                        label: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  addStudButt() async {
    final aname = nameControll.text.trim();
    final aage = ageControll.text.trim();
    final aplace = placeControll.text.trim();
    final aaddNO = admControll.text.trim();
    final aimage = image!.path;
    final student = StudentModel(
      name: aname,
      age: aage,
      addNO: aaddNO,
      place: aplace,
      id: null,
      image: aimage,
    );
    var result = await addStudent(student);
    // ignore: use_build_context_synchronously
    Navigator.pop(context, result);
  }

  noImage() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'please add photo',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        )));
  }
}
