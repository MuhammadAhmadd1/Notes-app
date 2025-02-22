import 'package:flutter/material.dart';
import 'package:mynotes/model/expense_structure.dart';

class ExpensesItems extends StatelessWidget {
  const ExpensesItems(
      {super.key, required this.expense, required this.onCardTap});
  final ExpenseStructure expense;
  final void Function() onCardTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardTap,
      splashColor: Theme.of(context).secondaryHeaderColor,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
          child: Column(
            children: [
              Text(
                expense.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      expense.description,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Date
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      expense.formattedDate,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
