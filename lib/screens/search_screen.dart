import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studentapp_new/database/database_functions.dart';
import 'package:studentapp_new/models/model.dart';
import 'package:studentapp_new/screens/profile_screen.dart';

class Search extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textTheme: Typography.whiteCupertino,
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0),
          )),
      hintColor: Colors.grey,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        toolbarTextStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  List data = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentlistnotifier,
        builder: (BuildContext context, List<StudentModel> studentlist,
            Widget? child) {
          final listed = studentlist.toList();
          final filtered = listed
              .where((element) =>
                  element.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
          if (filtered.isEmpty) {
            return const Center(
              child: Text('No Student', style: TextStyle(color: Colors.black)),
            );
          }
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = filtered[index];

              String nameval = data.name!.toLowerCase();

              if ((nameval).contains(query.toLowerCase().trim())) {
                return Card(
                    color: Colors.indigo,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ScreenProfile(student: data)));
                      },
                      leading: CircleAvatar(
                        radius: 34,
                        backgroundImage: FileImage(File(data.image!)),
                      ),
                      title: Text(
                        data.name!,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        data.addNO!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ));
              }
              return null;
            },
            itemCount: filtered.length,
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentlistnotifier,
        builder: (BuildContext context, List<StudentModel> studentlist,
            Widget? child) {
          final listed = studentlist.toList();
          final filtered = listed
              .where((element) =>
                  element.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = filtered[index];
              String nameval = data.name!.toLowerCase();
              if ((nameval).contains((query.toLowerCase().trim()))) {
                return Card(
                    color: Colors.indigo,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ScreenProfile(student: data)));
                      },
                      leading: CircleAvatar(
                        radius: 34,
                        backgroundImage: FileImage(File(data.image!)),
                      ),
                      title: Text(
                        data.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      subtitle: Text(
                        data.addNO!,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ));
              }

              return null;
            },
            itemCount: filtered.length,
          );
        });
  }
}
