import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Layout/Home_Layout.dart';
import 'package:todo_app/shared/cubit/Cubit.dart';
import 'package:todo_app/shared/cubit/States.dart';
import 'package:todo_app/shared/styles/Themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //final bool isDark;
  MyApp();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppCubit()..changeAppMode(),
      child:BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder:(context,state){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lighttheme,
        darkTheme: darktheme,
        themeMode: ThemeMode.system,
        home: HomeLayout(),
      );
    },
      ),
    );
  }
}
