import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http_calls/models/note.dart';
import 'package:http_calls/models/note_manipulations.dart';
import 'package:http_calls/services/note_service.dart';

class NoteModify extends StatefulWidget {
  final String noteId;
  NoteModify({this.noteId ,Key key}) : super(key: key);

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteId != null;

  NotesService get notesService => GetIt.I<NotesService>();
  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if(isEditing){

      setState(() {
        _isLoading = true;
      });

      notesService.getNote(widget.noteId)
          .then((response){
        setState(() {
          _isLoading = false;
        });
        if(response.error){
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        note = response.data;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ?  'Edit Note' : 'Create Note'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: _isLoading ? Center(child: CircularProgressIndicator(),) : Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Note Title'
              ),
            ),

            SizedBox(height: 10,),

            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                  hintText: 'Note Details'
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(
              height: 35,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async{
                    if(isEditing){
                      setState(() {
                        _isLoading = true;
                      });
                      final note = NoteManipulation(noteContent: _contentController.text, noteTitle: _titleController.text);
                      final result =  await notesService.updateNote(widget.noteId, note);

                      final title = 'Done';
                      final text = result.error ? (result.errorMessage ?? 'An error occurred')  : 'Your note was updated';

                      setState(() {
                        _isLoading = false;
                      });

                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(title),
                            content: Text(text),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child: Text('Ok'))
                            ],
                          )
                      ).then((data) => {
                        if(result.data){
                          Navigator.of(context).pop()
                        }
                      });
                    }else{
                      setState(() {
                        _isLoading = true;
                      });
                      final note = NoteManipulation(noteContent: _contentController.text, noteTitle: _titleController.text);
                      final result =  await notesService.createNote(note);

                      final title = 'Done';
                      final text = result.error ? (result.errorMessage ?? 'An error occurred')  : 'Your note was created';

                      setState(() {
                        _isLoading = false;
                      });

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(title),
                          content: Text(text),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text('Ok'))
                          ],
                        )
                      ).then((data) => {
                        if(result.data){
                          Navigator.of(context).pop()
                        }
                      });
                    }
                  },
                  child: Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}
