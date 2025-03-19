import 'package:flutter/material.dart';
import 'package:mynotes/model/notes_structure.dart';
import 'package:mynotes/notes.dart';
import 'package:mynotes/widget/expenses_list/notes_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynotes/provider/important_provider.dart';
import 'package:mynotes/provider/notes_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0; // Tracks the currently selected tab index

  void selectedPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _removeNote(NotesStructure note) {
    ref.read(notesProvider.notifier).removeNote(note);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: const Text('Note Deleted!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            ref.read(notesProvider.notifier).addNote(note);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final importantNotes = ref.watch(importantMealsProvider);

    Widget activePage = Notes();
    if (_selectPageIndex == 1) {
      activePage = NotesList(notes: importantNotes, onRemoveNote: _removeNote);
    }

    return Scaffold(
      appBar: _selectPageIndex == 0
          ? null
          : AppBar(
              title: Text('Important'),
            ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedPage,
        currentIndex: _selectPageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Important'),
        ],
      ),
    );
  }
}
