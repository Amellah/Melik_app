
import '../../model/git.repositories.model.dart';
import '../../repository/users.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// Event

abstract class GitRepoEvent {}

class FetchGitRepoEvent extends GitRepoEvent {
  final String userLogin;

  FetchGitRepoEvent({required this.userLogin});
}
// State

abstract class GitRepoState {
  final List<GitRepository> repos;

  GitRepoState({required this.repos});
}

class GitRepoSuccessState extends GitRepoState {
  GitRepoSuccessState({
    required super.repos,
  });
}

class GitRepoLoadingState extends GitRepoState {
  GitRepoLoadingState({
    required super.repos,
  });
}

class GitRepoErrorState extends GitRepoState {
  final String errorMessage;

  GitRepoErrorState({
    required this.errorMessage,
    required super.repos,
  });
}

class GitRepoInitialState extends GitRepoState {
  GitRepoInitialState() : super(repos: List.empty());
}

// Bloc

class GitRepoBloc extends Bloc<FetchGitRepoEvent, GitRepoState> {
  GitRepoBloc() : super(GitRepoInitialState()) {
    on((FetchGitRepoEvent event, emit) async {
      print("Fetching repos");
      emit(GitRepoLoadingState(
        repos: state.repos,
      ));

      UsersRepository repository = UsersRepository();
      try {
        String userLogin = event.userLogin;
        List<GitRepository> repos = await repository.getUserRepos(userLogin);

        emit(GitRepoSuccessState(
          repos: repos,
        ));
      } catch (exception) {
        emit(GitRepoErrorState(
          errorMessage: "Unable to fetch repos",
          repos: state.repos,
        ));
      }
    });
  }
}
