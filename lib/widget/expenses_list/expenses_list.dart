import 'package:flutter/material.dart';
import 'package:mynotes/model/expense_structure.dart';
import 'package:mynotes/screen/notes_screen.dart';
import 'package:mynotes/widget/expenses_list/expenses_items.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final void Function(ExpenseStructure expense) onRemoveExpense;
  void _selectScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => NotesScreen()));
  }

  final List<ExpenseStructure> expenses;
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
          child: ExpensesItems(expense: expenses[index],onCardTap: (){_selectScreen(context);})),
    );
  }
}
