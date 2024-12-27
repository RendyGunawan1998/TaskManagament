import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthDataSource? authDataSource;

  MyApp({super.key, this.authDataSource});
  final ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    final authDataSources =
        authDataSource ?? AuthDataSource(client: http.Client());
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(authDataSource: authDataSources),
              ),
              BlocProvider<TaskBloc>(
                create: (context) =>
                    TaskBloc(taskDatabase: TaskLocalDataSource.instance)
                      ..add(LoadTasks()),
              ),
              BlocProvider<ThemeBloc>(
                create: (context) => ThemeBloc(),
              ),
            ],
            child: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Task Manager',
                themeMode: themeState.themeMode,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                home: CheckingPageScreen(),
              );
            }));
      },
    );
  }
}
