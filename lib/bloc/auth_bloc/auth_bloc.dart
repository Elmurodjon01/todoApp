import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/data/repository/auth_repo.dart';
import 'package:todoapp/model/user/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  AuthRepo authRepo;
  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<SignInEvent>(_signIn);
  }

  void _signIn(SignInEvent event, Emitter<AuthBlocState> emit) async {
    print('bloc is called');
    emit(AuthLoading(true));

    try {
      // emit(AuthInitial());
      final res = await authRepo.signUp(event.user);
      emit(AuthLoading(false));
      emit(AuthSignedIn(userToken: res));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
