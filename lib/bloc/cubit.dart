import 'package:bloc/bloc.dart';
import 'package:bloc_sqflite_flutter_example/bloc/states.dart';
import 'package:bloc_sqflite_flutter_example/navScreens/ArchiveTasks.dart';
import 'package:bloc_sqflite_flutter_example/navScreens/DoneTasks.dart';
import 'package:bloc_sqflite_flutter_example/navScreens/NewTasks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit():super(AppInitialState());


  static AppCubit get(context)=> BlocProvider.of(context);

int currentIndex=0;
Database database;
List<Map> newTasks=[];
List<Map> doneTasks=[];
List<Map> archiveTasks=[];


List<String> titles=[
  "New Tasks",
  "Done Tasks",
  "Archived Tasks"
];


List<Widget> screens=[
  NewTasks(),
  DoneTasks(),
  ArchiveTasks()
];


void changeIndex(int index){
  currentIndex=index;
  emit(AppChangeBottomNavBarState());
}


  void createDatabase() 
  {
     openDatabase(
      'todo.db',
    version: 1,
    onCreate: (database,version){
       // id integer 
      //title String
     //date String
    //time String
   //status String


      print('database created');
      database.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT, time TEXT, status TEXT )'
      ).then((value){
        print('table created ');
      }).catchError((error){
        print("error occurred during executing database sql query for creating new table. ${error.toString()}");
      });
    },
    onOpen: (database) async{
      getDataFromDatabase(database);
      print('database opened');
    }
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });


  }

   insertToDatabse({
    @required String title,
    @required String time, 
    @required String date}
  ) async{
    await database.transaction((txn)
   {
     txn.rawInsert('INSERT INTO tasks (title, date, time, status) VALUES("$title","$date","$time","new")').then((value){
       print('inserted successfuly ');
       emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
     }).catchError((error){
       print('error in inserting data ${error.toString()}');
     });
   });
  }

void getDataFromDatabase(Database db) async
  {

    newTasks = [];
    doneTasks = [];
    archiveTasks = [];

    emit(AppGetDatabaseLoadingState());
    db.rawQuery(
      'SELECT * FROM tasks'
      ).then((value){
        emit(AppGetDatabaseState());
        value.forEach((element) { 
          if(element['status'] == 'new'){
            //newTasks.clear();
            newTasks.add(element);
          }else if(element['status'] == 'done'){
            //doneTasks.clear();
            doneTasks.add(element);
          }else{
            //archiveTasks.clear();
            archiveTasks.add(element);
            }
          print(element['status']);
        });      
      });
  }

bool isBottomSheetShowen = false;
IconData fabIcon = Icons.edit;

void changeBottomSheetState({
@required bool isShow,
@required IconData icon,
}){
  isBottomSheetShowen = isShow;
  fabIcon = icon;
  emit(AppChangeBottomSheetState());
}

Future<int> updateDate({
  @required String status,
  @required int id,
  }
)async{
  return await database.rawUpdate('UPDATE tasks SET status=? WHERE id =?',
  ['$status',id],
  ).then((value){
    getDataFromDatabase(database);
    emit(AppUpdateDatabaseState());
  });
}



Future<int> deleteDate({
  @required int id,
  }
)async{
  return await database.rawDelete('DELETE FROM tasks WHERE id =?',
  [id],
  ).then((value){
    getDataFromDatabase(database);
    emit(AppDeleteDatabaseState());
  });
}

}