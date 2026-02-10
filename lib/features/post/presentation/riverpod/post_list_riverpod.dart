import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_practise/core/network/dio_provider.dart';
import 'package:river_pod_practise/features/post/data/datasource/post_datasource.dart';
// import 'package:river_pod_practise/features/post/data/modal/post_model.dart';
import 'package:river_pod_practise/features/post/data/repository/post_repository_imp.dart';
import 'package:river_pod_practise/features/post/domain/entities/post.dart';
import 'package:river_pod_practise/features/post/presentation/riverpod/post_list_notifier.dart';

final postDatasourceProvider = Provider(
  (ref) => PostDatasource(ref.read(dioProvider)),
);

final postRepositoryProvider = Provider(
  (ref) => PostRepositoryImpl(ref.read(postDatasourceProvider)),
);

final postListProvider = AsyncNotifierProvider<PostListNotifier, List<Post>>(
  PostListNotifier.new,
);
