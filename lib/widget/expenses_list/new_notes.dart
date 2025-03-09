import 'package:flutter/material.dart';
import 'package:mynotes/model/notes_structure.dart';

class NewNotes extends StatefulWidget {
  const NewNotes({super.key, required this.onAddnote});
  final void Function(NotesStructure note) onAddnote;

  @override
  State<NewNotes> createState() => _NewNotesState();
}

class _NewNotesState extends State<NewNotes> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(2100);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Invalid Input',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Make sure all of the above entities are filled correctly',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _submitExpenseData() {
    // Check if title and description are empty (validation)
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      _showDialog();
      return;
    }

    widget.onAddnote(
      NotesStructure(
        title: _titleController.text,
        description: _descriptionController.text,
        date: _selectedDate!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: Expanded(
        // reverse: true,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardSpace + 16),
          child: Expanded(
            child: Column(
              children: [
                // Title Field with Date Picker
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        maxLength: 50,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.white70),
                        ),
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatter.format(_selectedDate!),
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Multiline Description Field
                Expanded(
                  child: SingleChildScrollView(
                    child: TextField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Buttons
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
