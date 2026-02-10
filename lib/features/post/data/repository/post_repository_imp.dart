import 'package:river_pod_practise/features/post/data/datasource/post_datasource.dart';
import 'package:river_pod_practise/features/post/data/modal/post_model.dart';
import 'package:river_pod_practise/features/post/domain/entities/post.dart';
import 'package:river_pod_practise/features/post/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDatasource datasource;

  PostRepositoryImpl(this.datasource);

  // @override
  // Future<List<Post>> getPosts(int page) => datasource.fetchPosts(page);
  @override
  Future<List<Post>> getPosts(int page) async {
    final models = await datasource.fetchPosts(page);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<Post> createPost(String title, String body) =>
      datasource.createPost(title, body);

  // @override
  // Future<Post> updatePost(Post post) =>
  //     datasource.updatePost(post as PostModel);
  @override
  Future<Post> updatePost(Post post) async {
    final model = PostModel.fromEntity(post);
    final updated = await datasource.updatePost(model);
    return updated.toEntity();
  }

  @override
  Future<void> deletePost(int id) => datasource.deletePost(id);
}
