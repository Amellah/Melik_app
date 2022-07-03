import 'dart:convert';
import 'dart:io';

import 'package:melik_app/model/users.model.dart';
import 'package:http/http.dart';
import '../model/git.repositories.model.dart';

class UsersRepository {
  Future<ListUsers> searchUsers(String keyword, int page, int pageSize) async {
    try {
      String url =
          "https://api.github.com/search/users?q=$keyword&page=$page&per_page=$pageSize";
      Response response = await get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        return ListUsers.fromJson(json.decode(response.body));
      } else {
        throw ("Error fetching data, http status: ${response.statusCode}");
      }
    } catch (exception) {
      print(exception.toString());
      throw ("Error fetching data, http status: Error");
    }
  }

  Future<List<GitRepository>> getUserRepos(String userLogin) async {
    try {
      String url = "https://api.github.com/users/$userLogin/repos";
      Response response = await get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        List parsed = json.decode(response.body);
        return parsed.map((e) => GitRepository.fromJson(e)).toList();
      } else {
        throw ("Error fetching data, http status: ${response.statusCode}");
      }
    } catch (exception) {
      print(exception.toString());
      throw ("Error fetching data, http status: Unknown error");
    }
  }
}
