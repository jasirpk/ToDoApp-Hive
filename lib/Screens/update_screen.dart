import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_app/Hive/model.dart';

class Update_Screen extends StatefulWidget {
  final Notes notes;

  const Update_Screen({super.key, required this.notes});

  @override
  State<Update_Screen> createState() => _Update_ScreenState();
}

class _Update_ScreenState extends State<Update_Screen> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  @override
  void initState() {
    titleController.text = widget.notes.title;
    descriptionController.text = widget.notes.descritption;
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
                'Upadate Note',
                style: TextStyle(
                    fontFamily: 'JacquesFracois',
                    fontSize: 22,
                    color: Colors.white),
              ),
            )),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/pngtree-vector-list-icon-png-image_991808.jpg'),
                  fit: BoxFit.fill)),
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
                        widget.notes.title = titleController.text.toString();
                        widget.notes.descritption =
                            descriptionController.text.toString();
                        await widget.notes.save();

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
