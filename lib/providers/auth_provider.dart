import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plagia_oc/utils/authentication.dart';
import 'package:plagia_oc/utils/user_provider.dart';

import '../utils/usermodel.dart';

final authProvider = StateNotifierProvider<Authentication, UserModel?>((ref) {
  return Authentication(ref);
});

final userDetailsProvider = FutureProvider<UserModel?>((ref) async {
  final auth = ref.watch(authProvider.notifier);
  return await auth.getUserDetails();
});

final userAuthProvider = FutureProvider<UserModel?>((ref) async {
  final auth = ref.watch(userProvider.notifier);
  return await auth.loadUser();
});
