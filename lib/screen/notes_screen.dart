import 'package:flutter/material.dart';
import 'package:mynotes/model/notes_structure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynotes/provider/important_provider.dart';

class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key, required this.note});

  final NotesStructure note;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final impNote = ref.watch(importantMealsProvider);
    final isImportant = impNote.contains(note);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(note.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(importantMealsProvider.notifier)
                  .toggleImportantNoteStatus(note);
              ScaffoldMessenger.of(context)
                  .clearSnackBars(); // Clear previous snackbars
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Marked As Favourite!'
                      : 'UnMarked As Favourite!'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(
              isImportant ? Icons.star : Icons.star_border,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 20),
              Text(
                'Date: ${note.formattedDate}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
