import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melik_app/bloc/counter.bloc.dart';
import 'package:flutter/material.dart';
import 'package:melik_app/bloc/theme.bloc.dart';
import 'package:melik_app/ui/pages/root.view.dart';
import 'bloc/users.bloc.dart';
import '../../bloc/git.user.repositories.bloc.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>CounterBloc()),
          BlocProvider(create: (context)=>ThemeBloc()),
          BlocProvider(create: (context)=>UsersBloc()),
          BlocProvider(create: (context) => GitRepoBloc()),
        ],
        child: const RootView()
    );
  }
}
