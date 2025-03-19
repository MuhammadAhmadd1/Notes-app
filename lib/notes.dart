import 'package:flutter/material.dart';
import 'package:mynotes/widget/expenses_list/notes_list.dart';
import 'package:mynotes/model/notes_structure.dart';
import 'package:mynotes/screen/new_notes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynotes/provider/notes_provider.dart';

class Notes extends ConsumerWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    void openAddexpenseOverlay() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewNotes(
          onAddnote: (newNote) {
            ref.read(notesProvider.notifier).addNote(newNote);
          },
        ),
      );
    }

    void removeNote(NotesStructure note) {
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

    Widget mainContent = Center(
      child: Text(
        'No Notes!',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
    );

    if (notes.isNotEmpty) {
      mainContent = NotesList(
        notes: notes,
        onRemoveNote: removeNote,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AhmadsNotes',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: openAddexpenseOverlay,
            icon: Icon(Icons.notes, size: 30, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
