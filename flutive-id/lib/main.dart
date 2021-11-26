import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '/bloc/ticket_bloc.dart';
import '/bloc/movie_bloc.dart';
import '/bloc/user_bloc.dart';
import 'ui/manage_page.dart';
import '/bloc/page_bloc.dart';
import 'services/firebase/auth_services.dart';

void main() async {
  // TODO: lock device screen orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthServices.userStream,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => PageBloc(OnInitialPage())),
            BlocProvider(create: (_) => UserBloc(UserInitial())),
            BlocProvider(
                create: (_) => MovieBloc(MovieInitial())..add(FetchMovie())),
            BlocProvider(create: (_) => TicketBloc(TicketState([]))),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ManagePage(),
          ),
        ));
  }
}
