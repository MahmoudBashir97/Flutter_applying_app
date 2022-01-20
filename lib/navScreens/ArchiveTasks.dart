import 'package:bloc_sqflite_flutter_example/bloc/cubit.dart';
import 'package:bloc_sqflite_flutter_example/bloc/states.dart';
import 'package:bloc_sqflite_flutter_example/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ArchiveTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
          listener:(context,state){} ,
          builder:(context,state){
            var tasks = AppCubit.get(context).archiveTasks;
          return ListView.separated(
        itemBuilder: (context,index) => buildTasksRow(tasks[index],context), 
        separatorBuilder: (context , index)=> Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
         itemCount: tasks.length,
         );
          });
  }
}