import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class Note{
  String noteId;
  String noteTitle;
  String noteContent;
  DateTime createdDateTime;
  DateTime latestEditDateTime;

  Note({
    this.noteId,
    this.noteTitle,
    this.createdDateTime,
    this.latestEditDateTime,
    this.noteContent,
});

  factory Note.fromJson(Map<String, dynamic> item) => _$NoteFromJson(item);

}