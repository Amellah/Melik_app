import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:melik_app/model/users.model.dart';
import 'package:melik_app/repository/users.repository.dart';

// Event

abstract class UsersEvent{}

class SearchUsersEvent extends UsersEvent{
  final String keyword;
  final int page;
  final int pageSize;
  SearchUsersEvent({
    required this.keyword,
    required this.page,
    required this.pageSize
});
}

class NextPageEvent extends SearchUsersEvent {
  NextPageEvent(
      {required super.keyword, required super.page, required super.pageSize});
}

// State

abstract class UserState{
  final List<User> users;
  final int currentPage;
  final int totalPages;
  final int pageSize;
  final String currentKeyword;
  const UserState({
    required this.users,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.currentKeyword,
});
}

class SearchUsersSuccessState extends UserState{
  SearchUsersSuccessState(
      {required super.users,
        required super.currentPage,
        required super.totalPages,
        required super.pageSize,
        required super.currentKeyword});
}

class SearchUsersLoadingState extends UserState{
  SearchUsersLoadingState(
      {required super.users ,
        required super.currentPage,
        required super.totalPages,
        required super.pageSize,
        required super.currentKeyword});
}

class SearchUsersErrorState extends UserState {
  final String errorMessage;

  SearchUsersErrorState(
      {required this.errorMessage,
        required super.users,
        required super.currentKeyword,
        required super.currentPage,
        required super.pageSize,
        required super.totalPages});
}

class UsersInitialState extends UserState {
  UsersInitialState()
      : super(
      users: [],
      currentPage: 0,
      currentKeyword: "",
      pageSize: 20,
      totalPages: 0);
}


// Bloc

class UsersBloc extends Bloc<UsersEvent, UserState>{
  UsersRepository usersRepository=UsersRepository();
  late UsersEvent currentEvent;
  UsersBloc() : super(UsersInitialState()) {
    on((SearchUsersEvent event, emit) async {
      currentEvent=event;
      emit(SearchUsersLoadingState(
        currentKeyword: state.currentKeyword,
        pageSize: state.pageSize,
        totalPages: state.totalPages,
        currentPage: state.currentPage,
        users: state.users
      ));
      try {
        ListUsers listUsers = await usersRepository.searchUsers(event.keyword, event.page, event.pageSize);
        int totalPages=(listUsers.totalCount / event.pageSize).floor();
        if(listUsers.totalCount % event.pageSize!=0) totalPages=totalPages+1;
        emit(SearchUsersSuccessState(
            users: listUsers.users,
            currentPage: event.page,
            totalPages: totalPages,
            pageSize: event.pageSize,
            currentKeyword: event.keyword
        ));
      } catch (e) {
        emit(SearchUsersErrorState(
            users: state.users,
            currentKeyword: state.currentKeyword,
            currentPage: state.currentPage,
            pageSize: state.pageSize,
            totalPages: state.totalPages,
            errorMessage: e.toString())
        );
      }
    });

    on((NextPageEvent event, emit) async {
      currentEvent=event;
      print ("Next Page${event.page}");
      try {
        ListUsers listUsers = await usersRepository.searchUsers(event.keyword, event.page, event.pageSize);
        int totalPages=(listUsers.totalCount / event.pageSize).floor();
        if(listUsers.totalCount % event.pageSize!=0) totalPages=totalPages+1;
        List<User> currentList=[...state.users];
        currentList.addAll(listUsers.users);
        emit(SearchUsersSuccessState(
            users: state.users,
            currentPage: event.page,
            totalPages: totalPages,
            pageSize: event.pageSize,
            currentKeyword: event.keyword
        ));
      } catch (e) {
        emit(SearchUsersErrorState(
            users: state.users,
            currentKeyword: state.currentKeyword,
            currentPage: state.currentPage,
            pageSize: state.pageSize,
            totalPages: state.totalPages,
            errorMessage: e.toString())
        );
      }
    });
  }
}


