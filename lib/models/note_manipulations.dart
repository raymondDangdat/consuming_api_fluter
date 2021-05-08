import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'note_manipulations.g.dart';

@JsonSerializable()
class NoteManipulation{
  String noteTitle;
  String noteContent;

  NoteManipulation({@required this.noteContent, @required this.noteTitle});


  Map<String, dynamic> toJson() => _$NoteManipulationToJson(this) ;
}