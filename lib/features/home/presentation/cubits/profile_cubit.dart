import 'package:apo/core/constants/secure_storage_keys.dart';
import 'package:apo/core/helpers/secure_storage_helper.dart';
import 'package:apo/core/mixins/cubit_mixin.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/repositories/base_repository.dart';
import 'package:apo/features/home/presentation/cubits/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState>
    with SafeEmitter<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> loadAuthStatus() async {
    safeEmit(state.copyWith(isLoading: true));
    final token = await SecureStorageHelper.getString(
      SecureStorageKey.authToken,
    );
    safeEmit(
      state.copyWith(
        isLoading: false,
        isAuthenticated: token.trim().isNotEmpty,
      ),
    );
  }

  Future<void> logout() async {
    if (state.logoutStatus.isLoading) return;
    safeEmit(state.copyWith(logoutStatus: const Result.loading()));
    await BaseRepository.clearSession();
    safeEmit(
      state.copyWith(
        isAuthenticated: false,
        logoutStatus: const Result.success(data: null),
      ),
    );
  }
}
