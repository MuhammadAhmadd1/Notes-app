import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mynotes/model/notes_structure.dart';

class ImportantMealsNotifier extends StateNotifier<List<NotesStructure>> {
  ImportantMealsNotifier() : super([]);
  bool toggleImportantNoteStatus(NotesStructure note) {
    final noteIsImportant = state.contains(note);
    if (noteIsImportant) {
      state = state.where((n) => n.id != note.id).toList();
      return false;
    } else {
      state = [...state, note];
      return true;
    }
  }
}

final importantMealsProvider =
    StateNotifierProvider<ImportantMealsNotifier, List<NotesStructure>>(
  (ref) {
    return ImportantMealsNotifier();
  },
);
