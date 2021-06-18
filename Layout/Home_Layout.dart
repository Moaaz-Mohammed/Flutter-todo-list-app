import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/shared/cubit/Cubit.dart';
import 'package:todo_app/shared/cubit/States.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          // this if condition for when Data inserted Successfully close the bottom sheet
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: cubit.scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.Titles[cubit.currentIndex],
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.Screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton
              (
              onPressed: ()
              {
                if (cubit.isBottomSheetShown)
                {
                  if (cubit.formKey.currentState.validate())
                  {
                    cubit.insertToDatabase
                      (
                      title: cubit.titleController.text,
                      time: cubit.timeController.text,
                      date: cubit.dateController.text,
                    );
                  }
                }
                else
                {
                  cubit.scaffoldKey.currentState
                      .showBottomSheet
                    (
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: cubit.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                                controller: cubit.titleController,
                                type: TextInputType.text,
                                Validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Kindly Enter a Title';
                                  }
                                  return null;
                                },
                                label: 'Title',
                                prefix: Icons.title),
                            SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                                controller: cubit.timeController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                      .then((value) => {
                                    cubit.timeController.text =
                                        value
                                            .format(context)
                                            .toString(),
                                    print(value.format(context))
                                  });
                                },
                                Validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Kindly Enter a Time';

                                  }
                                  return null;
                                },
                                label: 'Task Time',
                                prefix: Icons.watch_later),
                            SizedBox(
                              height: 10,
                            ),
                            defaultFormField(
                                controller: cubit.dateController,
                                type: TextInputType.datetime,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2050-01-01'),
                                  ).then((value) => {
                                    cubit.dateController.text =
                                        DateFormat.yMMMd()
                                            .format(value),
                                  });
                                },
                                Validate: (String value) {
                                  if (value.isEmpty) {
                                    return 'Kindly Enter a Date';

                                  }
                                  return null;
                                },
                                label: 'Task Date',
                                prefix: Icons.calendar_today)
                          ],
                        ),
                      ),
                    ),
                    elevation: 20,
                  )
                      .closed
                      .then((value) {
                    cubit.ChangeBottomSheetState(
                        isShown: false, icon: Icons.edit);
                  });
                  cubit.ChangeBottomSheetState(isShown: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeindex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}
