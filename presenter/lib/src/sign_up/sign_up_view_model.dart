import 'package:core/common/view_model/app_view_model.dart';
import 'package:core/common/view_model/future_runner.dart';
import 'package:injectable/injectable.dart';
import 'package:presenter/sign_up.dart';

abstract class SignUpViewModel extends AppViewModel<SignUpState> {
  factory SignUpViewModel({
    FutureRunner? futureRunner,
  }) = SignUpViewModelImpl;

  void signUp({
    required String name,
    required String email,
    required String password,
  });
}

@Injectable(as: SignUpViewModel)
class SignUpViewModelImpl extends AppBaseViewModel<SignUpState>
    implements SignUpViewModel {
  SignUpViewModelImpl({
    FutureRunner? futureRunner,
  }) : super(futureRunner: futureRunner);

  @override
  void signUp({
    required String name,
    required String email,
    required String password,
  }) {}
}
