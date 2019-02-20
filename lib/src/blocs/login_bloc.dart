import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:login_bloc/src/blocs/validators.dart';

class LoginBloc extends Object with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  LoginBloc();

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (email, password) {
    return true;
  });

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  submit(){
    var email = _emailController.value;
    var password =_passwordController.value;

    print('$email for $password');
  }

dispose() {
  _emailController.close();
  _passwordController.close();
}
  
}

//final loginBloc =LoginBloc();