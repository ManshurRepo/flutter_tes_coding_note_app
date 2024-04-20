import 'package:flutter/material.dart';
import 'package:flutter_jobtest_noteapp/common/constants/colors.dart';
import 'package:flutter_jobtest_noteapp/data/local_datasources/note_local_datasource.dart';

import '../../data/models/note_model/note_model.dart';
import 'add_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  bool isLoading = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> getNotes() async {
    setState(() {
      isLoading = true;
    });
    notes = await NoteLocalDatasource().getNotes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'My Notes',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
        backgroundColor: const Color.fromARGB(215, 208, 194, 100),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await getNotes();
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : notes.isEmpty
                ? const Center(child: Text('No Notes'))
                : GridView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.8),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailPage(
                              note: notes[index],
                            );
                          }));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorName.paperColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.deepOrangeAccent,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notes[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Colors.black,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      notes[index].content,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                      maxLines: 8,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: notes.length,
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 253, 60, 2),
        onPressed: () async {

          _refreshIndicatorKey.currentState?.show();
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddPage();
          }));

          await getNotes();
        },
        child: const ImageIcon(
          AssetImage('assets/feather-pen.png'),
          color: Colors.white,
        ),
      ),
    );
  }
}
