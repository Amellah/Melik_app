import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melik_app/bloc/theme.bloc.dart';

import 'counter.bloc.page.dart';
import 'counter.stateful.page.dart';
import 'git.users.page.dart';
import 'home.page.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context,state){
       return MaterialApp(
        theme: state.themeData,
        routes: {
          "/":(context)=>const HomePage(),
          "/counter1":(context)=>const CounterStatefulPage(),
          "/counter2":(context)=>const CounterBlocPage(),
          "/users":(context)=>const GitUsersPage()
        },
        initialRoute: "/",
      );
    }
    );
  }

}