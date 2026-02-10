import 'package:river_pod_practise/features/post/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts(int page);
  Future<Post> createPost(String title, String body);
  Future<Post> updatePost(Post post);
  Future<void> deletePost(int id);
}
