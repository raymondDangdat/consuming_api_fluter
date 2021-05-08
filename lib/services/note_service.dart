import 'package:flutter/cupertino.dart';
import 'package:http_calls/models/note.dart';
import 'package:http_calls/models/note_for_listing.dart';
import 'package:http_calls/models/note_manipulations.dart';

import 'package:chopper/chopper.dart';

part 'note_service.chopper.dart';

@ChopperApi(baseUrl: "/notes")
abstract class NotesService extends ChopperService{
  static const url = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const headers = {
    'apiKey': '16f6c54f-6d89-43df-85fa-59f90cf6d67f',
    'Content-Type': 'application/json'
  };

  static NotesService create([ChopperClient client]) => _$NoteService(client);

  @Get()
  Future<Response<List<NoteForListing>>> getNotesList();

  @Get(path: '{noteID}')
  Future<Response<Note>> getNote(@Path() String noteID);

  @Post()
  Future<Response<bool>> createNote(@Body() NoteManipulation item);


  @Put(path: '{noteID}')
  Future<Response<bool>> updateNote(@Path() String noteID, @Body() NoteManipulation item);

  @Delete(path: '{noteID}')
  Future<Response<bool>> deleteNote(@Path() String noteID);

}