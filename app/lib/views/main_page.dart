import 'package:app/views/downloads.dart';
import 'package:app/views/installed.dart';
import 'package:app/views/search.dart';
import 'package:app/views/settings.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    PageController page = PageController();
    List<SideMenuItem> items = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,
        title: 'Installed',
        onTap: () => page.jumpToPage(0),
        icon: const Icon(Icons.home),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Search',
        onTap: () => page.jumpToPage(1),
        icon: const Icon(Icons.search),
      ),
      SideMenuItem(
        priority: 2,
        title: 'Settings',
        onTap: () => page.jumpToPage(2),
        icon: const Icon(Icons.settings),
      ),
      SideMenuItem(
        priority: 3,
        title: 'Downloads',
        onTap: () => page.jumpToPage(3),
        icon: const Icon(Icons.download),
        badgeContent: const Text(
          '1',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Deck Tracker"),
        ),
        body: Scaffold(
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SideMenu(
                // page controller to manage a PageView
                controller: page,
                // will shows on top of all items, it can be a logo or a Title text
                // title: Image.asset('assets/images/easy_sidemenu.png'), //todo icon
                // will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
                footer: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('@diesersamat'),
                ),
                // List of SideMenuItem to show them on SideMenu
                items: items,
                style: SideMenuStyle(
                    displayMode: SideMenuDisplayMode.auto,
                    decoration: const BoxDecoration(),
                    openSideMenuWidth: 200,
                    compactSideMenuWidth: 40,
                    hoverColor: Colors.green[100],
                    selectedColor: Colors.lightGreen,
                    selectedIconColor: Colors.white,
                    unselectedIconColor: Colors.grey,
                    backgroundColor: Colors.grey[200]),
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: page,
                  children: const [
                    Center(
                      child: InstalledPage(),
                    ),
                    Center(
                      child: SearchPage(),
                    ),
                    Center(
                      child: SettingsPage(),
                    ),
                    Center(
                      child: DownloadsPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
