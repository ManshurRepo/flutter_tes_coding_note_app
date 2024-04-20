import 'package:flutter/material.dart';
import 'package:flutter_jobtest_noteapp/common/constants/colors.dart';
import 'package:flutter_jobtest_noteapp/data/local_datasources/note_local_datasource.dart';
import 'package:flutter_jobtest_noteapp/presentations/fitur_page.dart/homepage.dart';

import '../../data/models/note_model/note_model.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    super.key,
    required this.note,
  });
  final Note note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Edit Catatan',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
        backgroundColor: ColorName.appBarbackgroundColor,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [













            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                fillColor:
                    Colors.white,
                filled: true,
                labelText: 'Title',
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                border: OutlineInputBorder(),

                errorStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors
                          .lightGreen),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  fillColor: Colors.white,
                  filled: true,
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightGreen))),
              maxLines: 8,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Content wajib diisi';
                }
                return null;
              },
            ),














            const SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Note note = Note(
                id: widget.note.id,
                title: titleController.text,
                content: contentController.text,
                createdAt: DateTime.now());

            NoteLocalDatasource().updateNoteById(note);




            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) =>
                  false,
            );

          }
        },
        child: const ImageIcon(
          AssetImage('assets/save.png'),
          color: Colors.white,
        ),
      ),
    );
  }
}
