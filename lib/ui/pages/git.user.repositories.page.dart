import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/git.user.repositories.bloc.dart';
import '../../model/users.model.dart';


class GitRepositoriesPage extends StatefulWidget {
  final User user;
  const GitRepositoriesPage({Key? key, required this.user}) : super(key: key);

  @override
  State<GitRepositoriesPage> createState() => _GitRepositoriesPageState();
}

class _GitRepositoriesPageState extends State<GitRepositoriesPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<GitRepoBloc>()
        .add(FetchGitRepoEvent(userLogin: widget.user.login));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("User ${widget.user.login} Repositories"),
        ),
        body: Column(
          children: [
            BlocBuilder<GitRepoBloc, GitRepoState>(builder: (context, state) {
              if (state is GitRepoLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GitRepoErrorState) {
                return Center(
                    child: Column(children: [
                      Text(
                        state.errorMessage,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<GitRepoBloc>().add(
                                FetchGitRepoEvent(userLogin: widget.user.login));
                          },
                          child: const Text("Retry")),
                    ]));
              } else if (state is GitRepoSuccessState) {
                return Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var repo = state.repos[index];
                        return ListTile(
                            title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: MediaQuery.of(context).size.width * 0.65,child: Text(repo.name),),
                                  CircleAvatar(
                                    child: Text("${repo.stargazersCount}"),
                                  ),
                                ]));
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 2,
                        );
                      },
                      itemCount: state.repos.length),
                );
              } else {
                return Container();
              }
            }),
          ],
        ));
  }
}