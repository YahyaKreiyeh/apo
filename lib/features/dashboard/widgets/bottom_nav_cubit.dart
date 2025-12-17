import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  int selectedCategory = 0;

  BottomNavCubit() : super(0);

  void setIndex(int newIndex, {int? selectedCategory}) {
    if (selectedCategory != null) {
      this.selectedCategory = selectedCategory;
    }
    emit(newIndex);
  }
}
