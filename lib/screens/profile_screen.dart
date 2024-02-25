// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentapp_new/models/model.dart';

class ScreenProfile extends StatelessWidget {
  final StudentModel student;
  const ScreenProfile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        centerTitle: true,
      ),
      body: SizedBox(
        child: Center(
          child: Card(
            elevation: 25,
            color: Colors.indigo,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              width: 300,
              height: 400,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(File(student.image!))),
                  const SizedBox(
                    height: 20,
                  ),
                  profileData('Name', student.name!),
                  const SizedBox(
                    height: 20,
                  ),
                  profileData('Age', student.age!),
                  const SizedBox(
                    height: 20,
                  ),
                  profileData('Place', student.place!),
                  const SizedBox(
                    height: 20,
                  ),
                  profileData('Add No', student.addNO!),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  profileData(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          width: 70,
        ),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            ': $value',
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
