import 'package:dio/dio.dart';
import 'package:river_pod_practise/features/post/data/modal/post_model.dart';

class PostDatasource {
  final Dio dio;

  PostDatasource(this.dio);

  Future<List<PostModel>> fetchPosts(int page) async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
      queryParameters: {"_page": page, "_limit": 20},
    );
    return (response.data as List)
        .map((json) => PostModel.fromJson(json))
        .toList();
  }

  Future<PostModel> createPost(String title, String body) async {
    final response = await dio.post(
      'https://jsonplaceholder.typicode.com/posts',
      data: {'title': title, 'body': body, 'userId': 1},
    );
    return PostModel.fromJson(response.data);
  }

  Future<PostModel> updatePost(PostModel post) async {
    final response = await dio.put(
      'https://jsonplaceholder.typicode.com/posts/${post.id}',
      data: post.toJson(),
    );
    return PostModel.fromJson(response.data);
  }

  Future<void> deletePost(int id) async {
    await dio.delete('https://jsonplaceholder.typicode.com/posts/$id');
  }
}
