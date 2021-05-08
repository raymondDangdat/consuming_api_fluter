import 'dart:convert';

import 'package:http_calls/models/api_response.dart';
import 'package:http_calls/models/note.dart';
import 'package:http_calls/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:http_calls/models/note_manipulations.dart';

class NotesService{
  static const url = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': '16f6c54f-6d89-43df-85fa-59f90cf6d67f',
    'Content-Type': 'application/json'
  };
  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(Uri.parse(url + '/notes'),  headers: headers)
        .then((data) {
          if(data.statusCode == 200){
            final jsonData = json.decode(data.body);
            final notes = <NoteForListing>[];

            for (var item in jsonData){
              notes.add(NoteForListing.fromJson(item));
            }
            return APIResponse<List<NoteForListing>>(
              data: notes
            );
          }
          return APIResponse<List<NoteForListing>>(
              error: true, errorMessage: 'An error occurred'
          );
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        error: true, errorMessage: 'An error occurred'
    ));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(Uri.parse(url + '/notes/' + noteID),  headers: headers)
        .then((data) {
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);

        return APIResponse<Note>(
            data: Note.fromJson(jsonData)
        );
      }
      return APIResponse<Note>(
          error: true, errorMessage: 'An error occurred'
      );
    }).catchError((_) => APIResponse<Note>(
        error: true, errorMessage: 'An error occurred'
    ));
  }

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(Uri.parse(url + '/notes'),  headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if(data.statusCode == 201){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An error occurred'
      );
    }).catchError((_) => APIResponse<bool>(
        error: true, errorMessage: 'An error occurred'
    ));
  }


  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(Uri.parse(url + '/notes/' + noteID),  headers: headers, body: json.encode(item.toJson()))
        .then((data) {
      if(data.statusCode == 204){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An error occurred'
      );
    }).catchError((_) => APIResponse<bool>(
        error: true, errorMessage: 'An error occurred'
    ));
  }

  Future<APIResponse<bool>> deleteNote(String noteID) {
    return http.delete(Uri.parse(url + '/notes/' + noteID),  headers: headers)
        .then((data) {
      if(data.statusCode == 204){
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(
          error: true, errorMessage: 'An error occurred'
      );
    }).catchError((_) => APIResponse<bool>(
        error: true, errorMessage: 'An error occurred'
    ));
  }

}