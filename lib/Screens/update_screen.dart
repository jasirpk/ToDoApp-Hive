import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/Hive/user_model.dart';

class Update_Screen extends StatefulWidget {
  final UserModel users;

  const Update_Screen({super.key, required this.users});

  @override
  State<Update_Screen> createState() => _Update_ScreenState();
}

class _Update_ScreenState extends State<Update_Screen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  void initState() {
    titleController.text = widget.users.name;
    descriptionController.text = widget.users.age;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.red,
              title: Text(
                'Update Note',
                style: TextStyle(
                    fontFamily: 'JacquesFracois',
                    fontSize: 22,
                    color: Colors.white),
              ),
            )),
        body: Container(

          child: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AlertDialog(
                  title: Column(
                    children: [
                      Text("Make Better"),
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
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            widget.users.name = titleController.text.toString();
                            widget.users.age =
                                descriptionController.text.toString();
                            await widget.users.save();

                            Navigator.pop(context);
                          }
                        },
                        child: Text("Update")),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}