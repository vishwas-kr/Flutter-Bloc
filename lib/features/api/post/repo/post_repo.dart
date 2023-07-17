import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:bloc_learn/features/api/models/post_model.dart';

class PostRepo {
  static Future<List<PostModel>> fetchPost() async {
    var client = http.Client();
    List<PostModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostModel post = PostModel.fromJson(result[i]);
        posts.add(post);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        'title': 'HAHAHHAHAHA HA ',
        'body': 'hu huh uh huhu hu',
        'userId': '3',
      });
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
