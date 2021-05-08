// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_manipulations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteManipulation _$NoteManipulationFromJson(Map<String, dynamic> json) {
  return NoteManipulation(
    noteContent: json['noteContent'] as String,
    noteTitle: json['noteTitle'] as String,
  );
}

Map<String, dynamic> _$NoteManipulationToJson(NoteManipulation instance) =>
    <String, dynamic>{
      'noteTitle': instance.noteTitle,
      'noteContent': instance.noteContent,
    };
