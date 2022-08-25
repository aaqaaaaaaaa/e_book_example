import 'package:e_book_example/util/consts.dart';
import 'package:e_book_example/util/dialogs.dart';
import 'package:e_book_example/view_models/explore/explore_cubit.dart';
import 'package:e_book_example/view_models/genre/genre_cubit.dart';
import 'package:e_book_example/view_models/home/home_cubit.dart';
import 'package:e_book_example/view_models/main_screen/main_screen_cubit.dart';
import 'package:e_book_example/views/explore/explore.dart';
import 'package:e_book_example/views/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'home/home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController pageController;

  List<Widget> pages = [
    Home(),
    Explore(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainScreenCubit()..changeIndex(0),
          ),
          BlocProvider(
            create: (context) => HomeCubit(),
          ),
          BlocProvider(
            create: (context) => GenreCubit(),
          ),
          BlocProvider(
            create: (context) => ExploreCubit(),
          ),
        ],
        child: BlocBuilder<MainScreenCubit, MainScreenState>(
          builder: (context, state) {
            if (state is MainScreenInitial) {
              context.read<MainScreenCubit>().changeIndex(0);
            } else if (state is MainScreenChangeIndexState) {
              return Scaffold(
                body: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  allowImplicitScrolling: true,
                  children: pages,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.index,
                  onTap: (index) {
                    context.read<MainScreenCubit>().changeIndex(index);
                    onButtonPressed(index);
                  },
                  backgroundColor: Theme.of(context).primaryColor,
                  selectedItemColor: Theme.of(context).colorScheme.secondary,
                  unselectedItemColor: Colors.grey[500],
                  elevation: 20,
                  type: BottomNavigationBarType.fixed,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Feather.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Feather.compass),
                      label: 'Explore',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Feather.settings),
                      label: 'Settings',
                    ),
                  ],
                ),
              );
            }
            return Container(color: Colors.blue);
          },
        ),
      ),
    );
  }

  void onButtonPressed(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 800), curve: Curves.decelerate);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
