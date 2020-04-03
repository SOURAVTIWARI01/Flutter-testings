import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:help_giver/features/userhandling/presentation/bloc/authentication_bloc.dart';
import 'package:help_giver/features/userhandling/domain/usecases/authentication_usecase.dart';
import 'package:help_giver/features/userhandling/presentation/bloc/register_bloc.dart';
import 'package:help_giver/features/userhandling/domain/entities/register_entity.dart';
import 'package:help_giver/features/userhandling/domain/usecases/register_usecase.dart';
import 'package:help_giver/features/userhandling/domain/entities/user.dart';

class RegisterForm extends StatefulWidget {
  final RegisterBloc registerBloc;
  final AuthenticationBloc authenticationBloc; 

  RegisterForm({
    Key key,
    @required this.registerBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  final _addressController = TextEditingController();

  RegisterBloc get _registerBloc => widget.registerBloc;
  AuthenticationBloc get _authenticationBloc => widget.authenticationBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterEvent, RegisterState>(
      bloc: _registerBloc,
      builder: (
        BuildContext context,
        RegisterState state,
      ) {
        if (state is RegisterFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'username'),
                controller: _usernameController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'password'),
                controller: _passwordController,
                obscureText: true,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'mobile number'),
                controller: _mobileController,
                obscureText: true,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'address'),
                controller: _addressController,
                obscureText: true,
              ),
              RaisedButton(
                onPressed:
                    state is! RegisterLoading ? _onRegisterButtonPressed : null,
                child: Text('Register'),
              ),
              RaisedButton(
                onPressed: () {
                  _authenticationBloc.dispatch(LoggedOut());
                },
                child: Text('Cancel'),
              ),
              Container(
                child:
                    state is RegisterLoading ? CircularProgressIndicator() : null,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onRegisterButtonPressed() {
    User user = User(userName: _usernameController.text, 
                    password: _passwordController.text,
                    address: _addressController.text,
                    mobileNumber: _mobileController.text);
    _registerBloc.dispatch(RegisterButtonPressed(
      user: user,
    ));
  }
}