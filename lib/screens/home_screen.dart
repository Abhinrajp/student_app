import 'dart:io';

import 'package:flutter/material.dart';
import 'package:studentapp_new/database/database_functions.dart';
import 'package:studentapp_new/models/model.dart';
import 'package:studentapp_new/screens/edit_screen.dart';
import 'package:studentapp_new/screens/from_screen.dart';
import 'package:studentapp_new/screens/profile_screen.dart';
import 'package:studentapp_new/screens/search_screen.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({
    super.key,
  });

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  bool theGridView = false;

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                setState(() {
                  theGridView = !theGridView;
                });
              },
              icon: Icon(theGridView ? Icons.list : Icons.grid_view)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentlistnotifier,
              builder: (BuildContext ctx, List<StudentModel> studentlist,
                  Widget? child) {
                if (studentlist.isEmpty) {
                  return const Center(
                    child: Text('No Students'),
                  );
                }
                if (theGridView) {
                  return itsGridView(studentlist);
                } else {
                  return itsListView(studentlist);
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ScreenForm()))
              .then((value) {
            if (value != null) {
              getAllStudents();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  deleteStudentmsg(BuildContext context, id) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Are you sure'),
          content: const Text('Do you want delete the student details'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('no'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 132, 28, 21),
                ),
              ),
              onPressed: () {
                deleteStudent(id);
                Navigator.pop(context);
                getAllStudents();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(
                      'Deleted a Student details',
                      textAlign: TextAlign.center,
                    )));
              },
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }

  itsListView(List<StudentModel> studentlist) {
    return ListView.builder(
        itemBuilder: (context, index) {
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
                              ScreenProfile(student: studentlist[index])));
                },
                leading: CircleAvatar(
                  radius: 34,
                  backgroundImage: FileImage(File(studentlist[index].image!)),
                ),
                title: Text(
                  studentlist[index].name!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  studentlist[index].addNO!,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                trailing: SizedBox(
                  width: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditScreen(student: studentlist[index]),
                              ),
                            ).then((value) {
                              if (value != null) {
                                getAllStudents();
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )),
                      IconButton(
                          onPressed: () {
                            deleteStudentmsg(context, studentlist[index].id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 132, 28, 21),
                          )),
                    ],
                  ),
                )),
          );
        },
        itemCount: studentlist.length);
  }

  itsGridView(List<StudentModel> studentlist) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ScreenProfile(student: studentlist[index]),
                ),
              );
            },
            child: Card(
              color: Colors.indigo,
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          FileImage(File(studentlist[index].image!)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      studentlist[index].name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditScreen(student: studentlist[index]),
                            ),
                          ).then((value) {
                            if (value != null) {
                              getAllStudents();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteStudentmsg(context, studentlist[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 132, 28, 21),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: studentlist.length,
    );
  }
}
