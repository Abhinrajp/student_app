import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentapp_new/database/database_functions.dart';
import 'package:studentapp_new/models/model.dart';

class EditScreen extends StatefulWidget {
  final StudentModel student;
  const EditScreen({super.key, required this.student});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

final formKey = GlobalKey<FormState>();

class _EditScreenState extends State<EditScreen> {
  XFile? eimage;
  var nameControll = TextEditingController();
  final ageControll = TextEditingController();
  final placeControll = TextEditingController();
  final admControll = TextEditingController();
  @override
  void initState() {
    setState(() {
      nameControll.text = widget.student.name.toString();
      ageControll.text = widget.student.age.toString();
      placeControll.text = widget.student.place.toString();
      admControll.text = widget.student.addNO.toString();
      eimage = XFile(widget.student.image!);
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit the details'),
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
                      eimage != null
                          ? CircleAvatar(
                              radius: 80,
                              backgroundImage: FileImage(File(eimage!.path)),
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
                              var editimage = await picker.pickImage(
                                  source: ImageSource.gallery);
                              setState(() {
                                eimage = editimage;
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
                              color: Colors.blue,
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
                              color: Colors.blue,
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
                              color: Colors.blue,
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
                              color: Colors.blue,
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
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            updateStudButt();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Updated successfully',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.upload),
                        label: const Text('Update'),
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

  updateStudButt() async {
    final String tname = nameControll.text.trim();
    final String tage = ageControll.text.trim();
    final String tplace = placeControll.text.trim();
    final String tadNo = admControll.text.trim();
    final int? tid = widget.student.id;
    final timage = eimage!.path;
    final student = StudentModel(
        id: tid,
        name: tname,
        age: tage,
        addNO: tadNo,
        place: tplace,
        image: timage);

    var result = await updateStudent(student);

    Navigator.pop(context, result);
  }
}
