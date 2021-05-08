// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    noteId: json['noteId'] as String,
    noteTitle: json['noteTitle'] as String,
    createdDateTime: json['createdDateTime'] == null
        ? null
        : DateTime.parse(json['createdDateTime'] as String),
    latestEditDateTime: json['latestEditDateTime'] == null
        ? null
        : DateTime.parse(json['latestEditDateTime'] as String),
    noteContent: json['noteContent'] as String,
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'noteId': instance.noteId,
      'noteTitle': instance.noteTitle,
      'noteContent': instance.noteContent,
      'createdDateTime': instance.createdDateTime?.toIso8601String(),
      'latestEditDateTime': instance.latestEditDateTime?.toIso8601String(),
    };
