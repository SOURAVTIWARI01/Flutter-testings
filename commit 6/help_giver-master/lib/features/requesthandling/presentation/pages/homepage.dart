import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_giver/features/userhandling/presentation/widgets/app_drawer.dart';
import '../../../../injection_container.dart';
import 'package:help_giver/features/userhandling/presentation/bloc/authentication_bloc.dart';
import 'package:help_giver/features/userhandling/domain/usecases/authentication_usecase.dart';
import 'package:help_giver/features/requesthandling/presentation/bloc/request_bloc.dart';
import 'package:help_giver/features/requesthandling/presentation/pages/request_form.dart';
import 'package:help_giver/features/userhandling/presentation/pages/login_page.dart';


class HomePage extends StatelessWidget {
  final RequestBloc requestBloc;
  
  HomePage({
    Key key,
    @required this.requestBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
                   SizedBox(
            width: 50,
            child: Center(
              child: Text(
                authenticationBloc.userRepository.username1.toString(),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.power_settings_new),
              onPressed: () {
                authenticationBloc.dispatch(LoggedOut());
                Navigator.of(context).pushNamed(LoginPage.routeName);
              })
        ],
      ),
      body: Container(
        child: buildCenter(authenticationBloc, requestBloc),
      ),
    );
  }

  Center buildCenter(AuthenticationBloc authenticationBloc, RequestBloc requestBloc) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          
            Image.asset('images/makeARequest.png'),
            Text(''),
            SizedBox(height: 20,),
            Image.asset('images/seeMyTasks.png'), 
            Text(''),
             SizedBox(height: 20,),
            Image.asset('images/takeOnTasks.png'),
            RequestForm(
              requestBloc: requestBloc,
            ),
        //     RaisedButton(
        //       child: Text('logout '+ authenticationBloc.userRepository.username1.toString()),
        //       onPressed: () {
        //         authenticationBloc.dispatch(LoggedOut());
        //     },
        // )
          ],
        ),
    );
  }
} 
