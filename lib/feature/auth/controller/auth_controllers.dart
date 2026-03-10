import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:to_do/feature/auth/repository/auth_repo.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// final authProvider =
//     StateNotifierProvider<AuthController, bool>((ref) {
//   final repo = ref.read(authRepositoryProvider);
//   return AuthController(repo);
// });

// class AuthController extends StateNotifier<bool> {
//   final AuthRepository repo;

//   AuthController(this.repo) : super(false) {
//     checkLogin();
//   }

//   Future<void> checkLogin() async {
//     state = await repo.isLoggedIn();
//   }

//   Future<void> login(String email) async {
//     await repo.login(email);
//     state = true;
//   }

//   Future<void> logout() async {
//     await repo.logout();
//     state = false;
//   }
// }


final authProvider =
    StateNotifierProvider<AuthController, AsyncValue<bool>>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthController(repo);
});

class AuthController extends StateNotifier<AsyncValue<bool>> {
  final AuthRepository repo;

  AuthController(this.repo) : super(const AsyncValue.loading()) {
    checkLogin();
  }

  Future<void> checkLogin() async {
    try {
      final loggedIn = await repo.isLoggedIn();
      state = AsyncValue.data(loggedIn);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> login(String email) async {
    state = const AsyncValue.loading();

    try {
      await repo.login(email);
      state = const AsyncValue.data(true);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    await repo.logout();
    state = const AsyncValue.data(false);
  }
}
