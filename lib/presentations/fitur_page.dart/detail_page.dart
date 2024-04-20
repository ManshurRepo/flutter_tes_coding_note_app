import 'package:flutter/material.dart';
import 'package:flutter_jobtest_noteapp/common/constants/colors.dart';
import 'package:flutter_jobtest_noteapp/data/local_datasources/note_local_datasource.dart';

import '../../data/models/note_model/note_model.dart';
import 'edit_page.dart';
import 'homepage.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.note,
  });
  final Note note;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.paperColor,
      appBar: AppBar(
        title: const Text(
          'Detail Catatan',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
        backgroundColor: ColorName.appBarbackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Hapus catatan'),
                        content: const Text('Apakah anda yakin?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () async {
                                await NoteLocalDatasource()
                                    .deleteNoteById(widget.note.id!);

                                Navigator.pushAndRemoveUntil(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              child: const Text('Hapus')),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              )),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.note.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          Text(widget.note.content,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditPage(
              note: widget.note,
            );
          }));
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
