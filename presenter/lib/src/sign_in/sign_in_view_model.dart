import 'package:core/common/view_model/app_view_model.dart';
import 'package:core/common/view_model/future_runner.dart';
import 'package:presenter/common.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/sign_in.dart';

abstract class SignInViewModel extends AppViewModel<SignInState> {
  factory SignInViewModel({
    FutureRunner? futureRunner,
  }) = SignInViewModelImpl;

  void signIn({required String email, required String password});
}

@Injectable(as: SignInViewModel)
class SignInViewModelImpl extends AppBaseViewModel<SignInState>
    implements SignInViewModel {
  SignInViewModelImpl({
    FutureRunner? futureRunner,
  }) : super(futureRunner: futureRunner) {
    runFuture(() async {
      send(await _init());
    });
  }

  Future<SignInState> _init() async {
    send(SignInState.loading);
    final user = await _findLoggedUser();
    return user == UserView.empty
        ? SignInState.loaded
        : SignInStateUserAlreadyLoggedIn(user: user);
  }

  Future<UserView> _findLoggedUser() async {
    return UserView.empty;
  }

  @override
  void signIn({required String email, required String password}) {}
}
