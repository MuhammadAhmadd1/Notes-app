import 'package:flutter/material.dart';
import 'package:mynotes/model/notes_structure.dart';
import 'package:mynotes/screen/notes_screen.dart';
import 'package:mynotes/widget/expenses_list/notes_card_display.dart';

class NotesList extends StatelessWidget {
  const NotesList(
      {super.key, required this.notes, required this.onRemoveExpense});
  final void Function(NotesStructure nottes) onRemoveExpense;
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
          onRemoveExpense(notes[index]);
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
