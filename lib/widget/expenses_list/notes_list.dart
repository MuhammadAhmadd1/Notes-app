import 'package:flutter/material.dart';
import 'package:mynotes/model/notes_structure.dart';
import 'package:mynotes/screen/notes_screen.dart';
import 'package:mynotes/widget/expenses_list/notes_card_display.dart';

class NotesList extends StatelessWidget {
  const NotesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final void Function(NotesStructure expense) onRemoveExpense;
  void _selectScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => NotesScreen()));
  }

  final List<NotesStructure> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(
            expenses[index],
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          child: NotesCardDisplay(
              expense: expenses[index],
              onCardTap: () {
                _selectScreen(context);
              })),
    );
  }
}
