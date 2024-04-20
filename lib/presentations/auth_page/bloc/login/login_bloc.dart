import 'package:bloc/bloc.dart';
import 'package:flutter_jobtest_noteapp/data/remote_datasources/auth_remote_datasources.dart';
import 'package:flutter_jobtest_noteapp/data/models/responses/auth_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/request/login_request_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      await Future.delayed(const Duration(seconds: 3));
      final response = await AuthRemoteDatasource().login(event.data!);
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Succes(r)),
      );
    });
  }
}
