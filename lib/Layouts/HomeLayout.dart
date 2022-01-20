import 'package:bloc_sqflite_flutter_example/bloc/cubit.dart';
import 'package:bloc_sqflite_flutter_example/bloc/states.dart';
import 'package:bloc_sqflite_flutter_example/components/components.dart';
import 'package:bloc_sqflite_flutter_example/navScreens/ArchiveTasks.dart';
import 'package:bloc_sqflite_flutter_example/navScreens/DoneTasks.dart';
import 'package:bloc_sqflite_flutter_example/navScreens/NewTasks.dart';
import 'package:bloc_sqflite_flutter_example/utils/constants.dart';
import 'package:conditional/conditional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget{
  


Database database;
var scaffoldKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();


var _titleController = TextEditingController();
var _timeController= TextEditingController();
var _dateController= TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          // here we listen on inserting state to collapse bootom sheet after inserting
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
            _titleController.text = "";
            _timeController.text = "";
            _dateController.text = "";
          }
        },
        builder: (context,state){

          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            cubit.titles[cubit.currentIndex],
          ),
        ),
        body: Conditional(
          condition: state is! AppGetDatabaseLoadingState,
          onConditionTrue:  cubit.screens[cubit.currentIndex],
          onConditionFalse: Center(
            child: CircularProgressIndicator(),
          ))
        ,
        floatingActionButton: FloatingActionButton(
          onPressed:(){ 
            if(cubit.isBottomSheetShowen){
              if(formKey.currentState.validate()){
                print('title : ${_titleController.text} , time : ${_timeController.text} , date : ${_dateController.text}');

                cubit.insertToDatabse(
                  title: _titleController.text,
                  time: _timeController.text,
                  date: _dateController.text);
        
        
        //         insertToDatabse(
        //           title: _titleController.text.isEmpty ? "Empty" : _titleController.text,
        //           time: _timeController.text.isEmpty ? "Empty" : _timeController.text,
        //           date: _dateController.text.isEmpty ? "Empty" : _dateController.text,
        //         ).then((value){
                 
        //           getDataFromDatabase(database)
        // .then((value){
        //   Navigator.pop(context);
         
        //   // setState(() {
        //   //  tasks = value;
        //   //  isBottomSheetShowen=false;
        //   //  fabIcon = Icons.edit;
        //   //  print(tasks);   
        //   // });
        // }); 
                // });
              }
             
            }else{
               scaffoldKey.currentState.showBottomSheet(
             (context) => Container(
               padding: EdgeInsets.all(20.0),
               color: Colors.grey[300],
               child: Form(
                 key: formKey,
                              child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     defaultFormField(
                       controller: _titleController,
                        type: TextInputType.text,
                         validate: (String value){
                           if(value.isEmpty){
                             return 'title must not be empty';
                           }
                           return null;
                         },
                          label: 'Task Title',
                           prefix: Icons.title
                           ),

                           SizedBox(height: 15.0,),

                           defaultFormField(
                        controller: _timeController,
                        type: TextInputType.text,
                        onTap: ()
                        {
                        
                          // showTimePicker(
                          // context: context, initialTime: TimeOfDay.now()
                          // ).then((value){
                           
                          //     print('time now is ${value.format(context)}');
                          //     _titleController.text = value.format(context).toString();
                          // });

                        },
                         validate: (String value){
                           if(value.isEmpty){
                             return 'time must not be empty';
                           }
                           return null;
                         },
                          label: 'Task Time',
                           prefix: Icons.watch_later
                           ),

                            SizedBox(height: 15.0,),

                             defaultFormField(
                        controller: _dateController,
                        type: TextInputType.text,
                        onTap: ()
                        {
                        
                      //  showDatePicker(context: context, 
                      //  initialDate: DateTime.now()
                      //  , firstDate: DateTime.now(),
                      //   lastDate: DateTime.parse('2021-05-03')
                        // ).then((value){
                        //   _dateController.text = value.toString();
                        // }
                        // ).then((value){
                        //    var date = DateFormat.yMMMd().format(value).toString();
                        //    print('current date : $date');
                        //    _dateController.text = date;
                        // });

                        },
                         validate: (String value){
                           if(value.isEmpty){
                             return 'date must not be empty';
                           }
                           return null;
                         },
                          label: 'Task Date',
                           prefix: Icons.watch_later
                           ),
                           SizedBox(height: 15.0,)

                   ],
                 ),
               ),
             ),
             elevation: 20.0,
             ).closed.then((value){
              
              cubit.changeBottomSheetState(
                isShow: false,
               icon:Icons.edit);
             
             });

              cubit.changeBottomSheetState(
                isShow: true,
               icon:Icons.add);
            }
          
            // try{
            //   var name= await getName();
            //   print(name);
            //   //throw('some error!!!');
            // }catch(error){
            //   print('error ${error.toString()}');
            // }
          } ,
        child: Icon(cubit.fabIcon),),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10.0,
          currentIndex: cubit.currentIndex,
          onTap: (index)
          {
            cubit.changeIndex(index);  
          },
          items: [
           BottomNavigationBarItem(icon: Icon(
            Icons.menu,
          ),
           title: Text("tasks")),
           BottomNavigationBarItem(icon: Icon(
            Icons.check_circle_outline,
          ),
          title: Text("Done")
          ),
           BottomNavigationBarItem(icon: Icon(
            Icons.archive,
          ),
           title: Text("archive")),
        ],
        ),
      );
        },
        ),
    );
  }

  Future<String> getName() async{
    return 'Mahmoud Bashir';
  }

  


}