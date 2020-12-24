import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './home_screen.dart';
import '../cubits/app_bar/app_bar_cubit.dart';
import '../widgets/responsive.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(key: PageStorageKey('HomeScreen')),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];

  final Map<String, IconData> _icons = const {
    'Home': Icons.home,
    'Search': Icons.search,
    'Coming soon': Icons.queue_play_next,
    'Downloads': Icons.file_download,
    'More': Icons.menu
  };

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AppBarCubit>(
          create: (_) => AppBarCubit(), child: _screens[currentIndex]),
      bottomNavigationBar: !Responsive.isDesktop(context)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              items: _icons
                  .map(
                    (title, icon) => MapEntry(
                      title,
                      BottomNavigationBarItem(
                          icon: Icon(
                            icon,
                            size: 30,
                          ),
                          label: title),
                    ),
                  )
                  .values
                  .toList(),
              currentIndex: currentIndex,
              selectedItemColor: Colors.white,
              selectedFontSize: 11,
              unselectedItemColor: Colors.grey,
              unselectedFontSize: 11,
              onTap: (index) => setState(() => currentIndex = index),
            )
          : null,
    );
  }
}
