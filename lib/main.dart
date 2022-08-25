import 'package:e_book_example/theme/theme_config.dart';
import 'package:e_book_example/view_models/app_cubit/app_bloc.dart';
import 'package:e_book_example/view_models/main_screen/main_screen_cubit.dart';
import 'package:e_book_example/views/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData(state.theme),
            darkTheme: themeData(ThemeConfig.darkTheme),
            home: MultiBlocProvider(providers: [
              BlocProvider(
                create: (context) => MainScreenCubit(),
              ),
            ], child: MainScreen()),
          );
        },
      ),
    );
  }

  // Apply font to our app's theme
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.sourceSansProTextTheme(
        theme.textTheme,
      ),
      colorScheme: theme.colorScheme.copyWith(
        secondary: ThemeConfig.lightAccent,
      ),
    );
  }
}
