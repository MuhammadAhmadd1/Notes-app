import 'package:flutter/material.dart';
import 'package:mynotes/widget/expenses_list/expenses_list.dart';
import 'package:mynotes/model/expense_structure.dart';
import 'package:mynotes/widget/expenses_list/new_notes.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final List<ExpenseStructure> _registeredExpense = [

  ];

  void _openAddexpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewNotes(onAddExpense: _addExpense),
    );
  }

  void _addExpense(ExpenseStructure expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _removeExpenses(ExpenseStructure expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: const Text('Expense Deleted!'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(
              () {
                _registeredExpense.insert(expenseIndex, expense);
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
      child: Text('No Expense!',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface)),
    );
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        onRemoveExpense: _removeExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('MyNotes'),
        actions: [
          IconButton(
            onPressed: _openAddexpenseOverlay,
            icon: Icon(Icons.add),
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
