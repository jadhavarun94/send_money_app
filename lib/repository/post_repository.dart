import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class PostRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';
  final Box<Post> postBox = Hive.box<Post>('postsBox');

  Future<List<Post>> fetchPostsFromApi() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Post> posts = data.map((e) => Post.fromJson(e)).toList();

      // Save to Hive
      postBox.putAll({for (var post in posts) post.id: post});

      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  List<Post> fetchPostsFromLocal() {
    return postBox.values.toList();
  }
}
