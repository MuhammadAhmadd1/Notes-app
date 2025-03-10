import 'package:flutter/material.dart';
import 'package:mynotes/model/notes_structure.dart';
import 'package:mynotes/screen/notes_screen.dart';
import 'package:mynotes/screen/notes_card_display.dart';

class NotesList extends StatelessWidget {
  const NotesList(
      {super.key, required this.notes, required this.onRemoveNote});
  final void Function(NotesStructure nottes) onRemoveNote;
  void _selectScreen(BuildContext context, NotesStructure note) {

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NotesScreen(note: note,)));
  }

  final List<NotesStructure> notes;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          notes[index],
        ),
        onDismissed: (direction) {
          onRemoveNote(notes[index]);
        },
        child: NotesCardDisplay(
          expense: notes[index],
          onCardTap: () {
            _selectScreen(context,notes[index]);
          },
        ),
      ),
    );
  }
}
