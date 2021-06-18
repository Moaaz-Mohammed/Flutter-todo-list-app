import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/Cubit.dart';


// Default Form Field
Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChanged,
  bool isPassword = false,
  @required Function Validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  Function onTap,
  Color color,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      obscureText: isPassword,
      validator: Validate,
      onTap: onTap,
      style: TextStyle(color: color),
      decoration: InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          prefix,
          color: Colors.teal,
          size: 25,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

// Task Item Widget
Widget TaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 55,
              child: Text(
                '${model['time']}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${model['date']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            IconButton(
                icon: Icon(Icons.check_box, color: Colors.green,size: 30,),
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                }),
            IconButton(
                icon: Icon(
                  Icons.archive_rounded,
                  color: Colors.red,
                  size: 30,
                ),
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archive', id: model['id']);
                }),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

// Tasks Builder for Todo App
Widget TasksBuilder({
  @required List<Map> Tasks,
}) =>
    ConditionalBuilder(
      condition: Tasks.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => TaskItem(Tasks[index], context),
          separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 2.0,
                color: Colors.grey.shade300,
              ),
          itemCount: Tasks.length),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.menu, size: 100, color: Colors.grey),
            Text(
              'No Tasks Yet, Please add some!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
