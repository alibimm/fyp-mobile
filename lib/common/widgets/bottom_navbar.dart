import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp_mobile/service/navigation/base_navigation.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selected,
      onTap: (ind) {
        setState(() {
          selected = ind;
        });
        switch (ind) {
          case 0:
            BlocProvider.of<BaseNavigation>(context).navigateTo('home');
            break;
          case 1:
            BlocProvider.of<BaseNavigation>(context).navigateTo('statistics');
            break;
          case 2:
            BlocProvider.of<BaseNavigation>(context).navigateTo('profile');
            break;
          default:
            BlocProvider.of<BaseNavigation>(context).navigateTo('default');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.numbers),
          label: 'Stats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
