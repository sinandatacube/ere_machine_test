import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:machine_test/models/login_model.dart';
import 'package:machine_test/repositories/api_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    ApiRepository _apirep = ApiRepository();
    on<CheckLogin>((event, emit) async {
      emit(LoginChecking());
      Map res = await _apirep.loginCheck(event.login);
      if (res['status'] == "authSuccess") {
        emit(LoginSuccess());
      } else if (res['status'] == "authFailed") {
        emit(LoginFailed());
      } else {
        emit(LoginError(error: res['error']));
      }
    });
  }
}
