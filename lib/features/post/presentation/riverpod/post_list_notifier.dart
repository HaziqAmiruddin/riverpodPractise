import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_practise/features/post/data/modal/post_model.dart';
import 'package:river_pod_practise/features/post/domain/entities/post.dart';
import 'package:river_pod_practise/features/post/presentation/riverpod/post_list_riverpod.dart';

class PostListNotifier extends AsyncNotifier<List<Post>> {
  int _page = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  Future<List<Post>> build() async {
    _page = 1;
    _hasMore = true;
    return _fetchPage();
  }

  Future<List<Post>> _fetchPage() async {
    final datasource = ref.read(postDatasourceProvider);
    final posts = await datasource.fetchPosts(_page);
    if (posts.isEmpty) _hasMore = false;
    return posts.map((e) => e.toEntity()).toList();
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore || state.isLoading) return;

    _isLoadingMore = true;
    _page++;

    try {
      final morePosts = await ref
          .read(postDatasourceProvider)
          .fetchPosts(_page);
      final current = state.value ?? [];
      state = AsyncData([...current, ...morePosts.map((e) => e.toEntity())]);
      if (morePosts.isEmpty) _hasMore = false;
    } catch (e, _) {
      // state = AsyncError(e, st);
      _page--;
      state = AsyncData(state.value ?? []);
    }

    _isLoadingMore = false;
  }

  Future<void> refresh() async {
    _page = 1;
    _hasMore = true;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchPage());
  }

  /// Optimistic Create
  Future<void> addPost(String title, String body) async {
    final current = state.value ?? [];
    final tempPost = PostModel(
      userId: 1,
      id: DateTime.now().millisecondsSinceEpoch,
      title: title,
      body: body,
    );

    state = AsyncData([tempPost, ...current]);

    try {
      final created = await ref
          .read(postDatasourceProvider)
          .createPost(title, body);
      final newList = state.value!
          .map((e) => e.id == tempPost.id ? created : e)
          .toList();
      state = AsyncData(newList);
    } catch (e) {
      state = AsyncData(current);
    }
  }

  Future<void> deletePost(Post post) async {
    final current = state.value ?? [];
    // Optimistic update
    state = AsyncData(current.where((p) => p.id != post.id).toList());

    try {
      // Convert Post → PostModel for datasource
      final model = PostModel.fromEntity(post);
      await ref.read(postDatasourceProvider).deletePost(model.id);
    } catch (_) {
      // revert
      state = AsyncData(current);
    }
  }

  Future<void> updatePost(Post updated) async {
    final previous = state.value ?? [];

    // optimistic
    state = AsyncData([
      for (final p in previous)
        if (p.id == updated.id) updated else p,
    ]);

    try {
      final saved = await ref.read(postRepositoryProvider).updatePost(updated);

      state = AsyncData([
        for (final p in state.value!)
          if (p.id == saved.id) saved else p,
      ]);
    } catch (_) {
      state = AsyncData(previous);
    }
  }
}
