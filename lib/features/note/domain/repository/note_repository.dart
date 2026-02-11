import 'package:river_pod_practise/features/note/domain/entities/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> watchNotes();
  Future<void> addNote(String title, String content);
  Future<void> deleteNote(int id);
  Future<void> updateNote(Note note);
}
