import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../ui/themes/custom.themes.dart';

abstract class ThemeEvent{}
class SwitchThemeEvent extends ThemeEvent{}

abstract class ThemeState{
  ThemeData themeData;
  ThemeState({
    required this.themeData,
 });
}

class ThemeSuccessState extends ThemeState{
  ThemeSuccessState({required super.themeData});

}

class InitialThemeState extends ThemeState {
  InitialThemeState() : super(
      themeData: CustomThemes.themes[0]
  );
}

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  int currentThemeIndex=0;
  List<ThemeData> themes=CustomThemes.themes;
  ThemeBloc() : super(InitialThemeState()){
    on((SwitchThemeEvent event, emit){
      ++currentThemeIndex;
      if(currentThemeIndex>themes.length){
        currentThemeIndex=0;
      }
      emit(ThemeSuccessState(themeData: themes[currentThemeIndex]));
    });
  }
}

