import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynotes/model/notes_structure.dart';

class NotesNotifier extends StateNotifier<List<NotesStructure>> {
  NotesNotifier() : super([]);

  void addNote(NotesStructure note) {
    state = [...state, note];
  }

  void removeNote(NotesStructure note) {
    state = state.where((n) => n.id != note.id).toList();
    
  }
}

final notesProvider =
    StateNotifierProvider<NotesNotifier, List<NotesStructure>>(
  (ref) => NotesNotifier(),
);
