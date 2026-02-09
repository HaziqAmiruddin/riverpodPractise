import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:river_pod_practise/core/network/dio_provider.dart';
import 'package:river_pod_practise/features/home_page/data/datasources/user_datasource.dart';
import 'package:river_pod_practise/features/home_page/data/repositories/user_repository_impldata.dart';
import 'package:river_pod_practise/features/home_page/domain/entities/user.dart';
import 'package:river_pod_practise/features/home_page/domain/usecases/get_users.dart';
import 'package:river_pod_practise/features/home_page/presentation/riverpod/riverpod_modal.dart';

///////////////////////////////////////////////////////////////////////////////

final initialNumber = StateProvider<int>((ref) {
  return 0;
});

final riverpodHard = ChangeNotifierProvider<RiverpodModal>((ref) {
  return RiverpodModal(counter: 0);
});

///////////////////////////////////////////////////////////////////////////////

//dio
// final dioProvider = Provider((ref) => Dio());
// final dioProvider = Provider((ref) {
//   final dio = Dio();

//   dio.options.headers = {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//     'User-Agent': 'Mozilla/5.0',
//   };

//   return dio;
// });

//datasource(get data)
final userDataSourceProvider = Provider(
  (ref) => UserDatasource(ref.read(dioProvider)),
);

//repository
final userRepositoryProvider = Provider(
  (ref) => UserRepositoryImpldata(ref.read(userDataSourceProvider)),
);

//usercase
final getUsersProvider = Provider(
  (ref) => GetUsers(ref.read(userRepositoryProvider)),
);

//state provider
final usersProvider = FutureProvider<List<User>>((ref) async {
  return ref.read(getUsersProvider)();
});
