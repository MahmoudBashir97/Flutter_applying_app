import 'package:bloc_sqflite_flutter_example/bloc/cubit.dart';
import 'package:flutter/material.dart';


 Widget buildTasksRow(Map model,context)=> Dismissible(
   key: Key(model['id'].toString()),
   onDismissed: (direcion){
     AppCubit.get(context).deleteDate(id: model['id']);
   },
    child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
        children: [
          CircleAvatar(
            radius: 40.0,
            child: Text(
              '${model['time']}',
            ),
          ),
          SizedBox(width: 20.0,),
          Expanded(
                    child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('${model['title']}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),),
               Text('${model['date']}',
              style: TextStyle(
                fontSize: 18.0,
               color: Colors.grey
              ),)
            ],),
          ),
          SizedBox(width: 20.0,),
          IconButton(
            icon: Icon(Icons.check,
            color: Colors.green,),
            onPressed: (){
              AppCubit.get(context).updateDate(status: 'done', id: model['id']);
            },
          ),
          IconButton(
            icon: Icon(Icons.archive,
            color: Colors.grey,),
            onPressed: (){
              AppCubit.get(context).updateDate(status: 'archive', id: model['id']);

            },
          ),
        ],
        ),
      ),
 );


    
  Widget defaultFormField({
    @required TextEditingController controller,
    @required TextInputType type,
    Function onSubmit,
    Function onChange,
    Function onTap,
    @required Function validate,
    @required String label,
    @required IconData prefix,
    IconData suffix,
    bool isEnabled=true,
    bool isPassword = false,
  })=> TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    onFieldSubmitted:onSubmit,
    onChanged: onChange,
    onTap: onTap,
    enabled: isEnabled,
    validator: validate,
    obscureText: isPassword,
    decoration: InputDecoration(
     labelText: label,
     prefixIcon: Icon(prefix), 
     suffixIcon: suffix != null ? Icon(suffix)  : null,
     border: OutlineInputBorder(),
    ),
  );

  Widget defaultButton({
    @required String buttonText ,
    double width = double.infinity,
    Color background = Colors.blue,
    @required Function function,
    bool isUpperCase = true,
    double radius
    })=> Container(
    width: width,
    color: background,
    child: MaterialButton(
      height: 40.0,
      onPressed:function,
      child: Text(
        isUpperCase? buttonText.toUpperCase():buttonText,
        style: TextStyle(
          color: Colors.white,
        ),
      ), 
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background
      ),
      
  );

  Widget getForm(){
    return Column(
      children: [
  
      Container
      (
        width: 200.0,
        height: 40.0,
        child: TextFormField(
          
          ),
      ),
    ],);
  }