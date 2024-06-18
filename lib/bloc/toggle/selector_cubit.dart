import 'package:bloc/bloc.dart';

class SelectorCubit extends Cubit<int?> {
  SelectorCubit() : super(null);

  void changeChoice(bool newValue, int index) {
    emit(newValue ? index : null);
  }
}
