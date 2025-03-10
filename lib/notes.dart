import 'package:flutter/material.dart';
import 'package:mynotes/widget/expenses_list/notes_list.dart';
import 'package:mynotes/model/notes_structure.dart';
import 'package:mynotes/screen/new_notes.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final List<NotesStructure> _registeredExpense = [];

  void _openAddexpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewNotes(onAddnote: _addNote),
    );
  }

  void _addNote(NotesStructure expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeNote(NotesStructure notess) {
    final expenseIndex = _registeredExpense.indexOf(notess);
    setState(() {
      _registeredExpense.remove(notess);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: const Text('Note Deleted!'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(
              () {
                _registeredExpense.insert(expenseIndex, notess);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No Notes!',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface)),
    );
    if (_registeredExpense.isNotEmpty) {
      mainContent = NotesList(
        notes: _registeredExpense,
        onRemoveNote: _removeNote,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('AhmadsNotes',style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: _openAddexpenseOverlay,
            icon: Icon(Icons.notes,size: 30,color: Colors.white,),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
