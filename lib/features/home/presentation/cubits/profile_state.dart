import 'package:apo/core/models/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isAuthenticated,
    @Default(false) bool isLoading,
    @Default(Result.empty()) Result<void> logoutStatus,
  }) = _ProfileState;
}
