import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/Hive/box.dart';
import 'package:todo_app/Hive/model.dart';
import 'package:todo_app/Screens/update_screen.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              titleController.clear();
              descriptionController.clear();
              showMyDialog(context);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(
                backgroundColor: Colors.red,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create Note',
                      style: TextStyle(
                          fontFamily: 'JacquesFracois',
                          fontSize: 22,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.note,
                      color: Colors.white,
                    )
                  ],
                ),
              )),
          body: ValueListenableBuilder<Box<Notes>>(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, _) {
                var data = box.values.toList().cast<Notes>();
                if (data.isEmpty) {
                  return Center(
                    child: Lottie.asset(
                        'assets/images/Animation - 1705067403205.json',
                        fit: BoxFit.cover),
                  );
                } else {
                  return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(right: 8, left: 8, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              editDialog(
                                  data[index],
                                  data[index].title.toString(),
                                  data[index].descritption.toString());

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx1) =>
                                          Update_Screen(notes: data[index])));
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 10,
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListTile(
                                    title: Text(
                                      data[index].title.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    subtitle: Text(
                                        data[index].descritption.toString()),
                                    trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    'Are you sure you want to delete?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Cancel')),
                                                  TextButton(
                                                      onPressed: () {
                                                        deleteItem(data[index]);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Delete'))
                                                ],
                                              );
                                            });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        );
                      });
                }
              })),
    );
  }

  Future<void> showMyDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text("Add Notes"),
              ],
            ),
            content: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'title required';
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Enter Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'content required';
                        }
                        return null;
                      },
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: "Enter Description",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      final data = Notes(
                          title: titleController.text.toString(),
                          descritption: descriptionController.text.toString());
                      final box = Boxes.getData();
                      box.add(data);
                      // data.save();
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add")),
            ],
          );
        });
  }

  void deleteItem(Notes notes) async {
    await notes.delete();
  }

  Future<void> editDialog(Notes notes, String title, String description) async {
    titleController.text = title;
    descriptionController.text = description;
  }
}
