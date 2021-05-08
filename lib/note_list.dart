import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http_calls/note_delete.dart';
import 'package:http_calls/note_modify.dart';
import 'package:http_calls/services/note_service.dart';

import 'models/api_response.dart';
import 'models/note_for_listing.dart';
class NoteList extends StatefulWidget {
  const NoteList({Key key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  NotesService get service => GetIt.I<NotesService>();

  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour} : ${dateTime.minute}';
  }

  APIResponse<List<NoteForListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async{
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getNotesList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Notes'),

      ),

      body:  Builder(
          builder: (_){
            if(_isLoading){
              return Center(child: CircularProgressIndicator());
            }if(_apiResponse.error){
              return Center(child: Text(_apiResponse.errorMessage),);
            }
            return ListView.separated(
                itemBuilder: (_, index){
              final note = _apiResponse.data[index];
              return Dismissible(
                key: ValueKey(note.noteID),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction){

                },
                confirmDismiss: (direction) async {
                  final result =  await showDialog(context: context, builder: (_) => NoteDelete());
                  if(result){
                    final deleteResult = await service.deleteNote(_apiResponse.data[index].noteID);
                    var message;
                    if(deleteResult != null && deleteResult.data == true){
                      message = 'The note was deleted successfully';
                    }else{
                      message = deleteResult?.errorMessage ?? 'An error occurred';
                    }

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Done'),
                          content: Text(message),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text('Ok'))
                          ],
                        ));

                    return deleteResult?.data ?? false;
                  }
                  print(result);
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  padding: EdgeInsets.only(left: 16.0),
                  child: Align(child: Icon(Icons.delete, color: Colors.white,), alignment: Alignment.centerLeft,),
                ),
                child: ListTile(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteModify( noteId: note.noteID,))).then((data){
                      _fetchNotes();
                    });
                  },
                  title: Text(_apiResponse.data[index].noteTitle, style: TextStyle(color: Theme.of(context).primaryColor),),
                  subtitle: Text('Last edited on ${formatDateTime(note.latestEditDateTime ?? _apiResponse.data[index].createDateTime)}'),
                ),
              );
            }, separatorBuilder: (_, __) => Divider(height: 1, color: Colors.grey,),
                itemCount: _apiResponse.data.length
            );
          }),


      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteModify()));
      }, child: IconButton(icon: Icon(Icons.add
      ), onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteModify())).then((data) {
          _fetchNotes();
        });
      }),),
    );
  }
}
