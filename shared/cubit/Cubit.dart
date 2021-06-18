import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Modules/ArchivedTasksScreen.dart';
import 'package:todo_app/Modules/DoneTasksScreen.dart';
import 'package:todo_app/Modules/NewTasksScreen.dart';
import 'package:todo_app/shared/cubit/States.dart';



class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  //Screens of App
  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  //Screens Title
  List<String> Titles = [
    'Pending Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];


  void changeindex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  Database database;
  createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database Created');
        database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT, status TEXT)')
            .then((value) => (value) {
                  print('Table created');
                })
            .catchError((error) {
          print('Error when Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDatafromDatabase(database);
        print('Database Opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO Tasks (title,date,time,status) VALUES ("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted Successfuly');
        emit(AppInsertDatabaseState());
        getDatafromDatabase(database);
      }).catchError((error) {
        print('Error when Insert to Table ${error.toString()}');
      });
      return null;
    });
  }

  void getDatafromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM Tasks').then((value)
    {
      value.forEach((element) {
        if (element['status'] == 'new')
          newTasks.add(element);
        else if (element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }

  void updateData({
    @required String status,
    @required int id,
  }) async {
    // Update some record
    database.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?',['$status', id]).then((value)
    {
      getDatafromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void deleteData(
  {
    @required int id,
}
      )async
  {
    database
        .rawDelete('DELETE FROM Tasks WHERE id = ?' , [id]).then((value)
    {
      getDatafromDatabase(database);
      emit(AppDeleteDatabaseState());
    }
    );
  }

    bool isBottomSheetShown = false;
    IconData fabIcon = Icons.edit;

    void ChangeBottomSheetState({
      @required bool isShown,
      @required IconData icon,
    }) {
      isBottomSheetShown = isShown;
      fabIcon = icon;

      emit(AppChangeBottomSheetState());
    }

    var scaffoldKey = GlobalKey<ScaffoldState>();
    final formKey = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var timeController = TextEditingController();
    var dateController = TextEditingController();

  bool isDark = false;
  //ThemeMode appMode = ThemeMode.dark;

  void changeAppMode()
  {
    isDark = !isDark;
    emit(AppChangeModeState());
  }
  }
