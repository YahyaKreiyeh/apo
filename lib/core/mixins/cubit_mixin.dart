import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeEmitter<State> on BlocBase<State> {
  void safeEmit(State state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
