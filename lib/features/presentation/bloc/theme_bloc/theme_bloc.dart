import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleTheme>((event, emit) {
      // Toggle antara tema gelap dan terang
      final newThemeMode =
          state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      emit(ThemeState(themeMode: newThemeMode));
    });
  }
}
