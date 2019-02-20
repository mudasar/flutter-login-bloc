import 'package:flutter/material.dart';
import 'package:login_bloc/src/blocs/login_bloc.dart';
import '../blocs/provider.dart';

class LoginPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    final loginBloc = Provider.of(context).loginBloc;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
             emailField(loginBloc),
             passwordField(loginBloc),
             submitButton(loginBloc),
            ],
          ),
        ),
      ),
    );
  }
  emailField(LoginBloc bloc) {
    return Container(
      child: StreamBuilder(
        stream:  bloc.email,
              builder: (context, snapshot) { 
                return TextField(
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'you@email.com',
            errorText: snapshot.error,
          ),
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          autofocus: true,
          
          onChanged: bloc.changeEmail,
        );},
      ),
    );
  }

  passwordField(LoginBloc loginBloc) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.0),
      child: StreamBuilder(
        stream: loginBloc.password,
              builder: (context, snapshot) {

               return TextField(
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Password',
            errorText: snapshot.error,
          ),
          autocorrect: false,
          autofocus: true,
          obscureText: true,
          
          onChanged: loginBloc.changePassword,
        );
        },
      ),
    );
  }

  submitButton(LoginBloc loginBloc) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(20.0),
      child: StreamBuilder(
        stream: loginBloc.submitValid,
              builder: (context, snapshot) => RaisedButton(
            onPressed: snapshot.hasData ? loginBloc.submit: null,
            color: Colors.blue,
            child: Text('Login', style: TextStyle(color: Colors.white),), 
            animationDuration: Duration(milliseconds: 500),
          ),
      )
      );
  }

}