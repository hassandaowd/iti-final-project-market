import 'package:flutter/material.dart';
import 'package:iti_final_project/bottom_nav_screens/categories_screen.dart';
import 'package:iti_final_project/bottom_nav_screens/home_screen.dart';
import 'package:iti_final_project/bottom_nav_screens/settings_screen.dart';
import 'package:iti_final_project/search_screen.dart';
import 'package:iti_final_project/shared/constants.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('MARKET'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context)=> const SearchScreen()
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          if (currentIndex == 2)
            IconButton(
              onPressed: (){
                logOut(context);
              },
              icon: const Icon(Icons.logout_outlined),
            ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
