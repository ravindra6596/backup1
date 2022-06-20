import 'package:ecom_daru/home/inner_screens/brands_navigation_rail.dart';
import 'package:flutter/material.dart';

class TabBarTest extends StatefulWidget {
  const TabBarTest({Key? key}) : super(key: key);
  static const routeName = '/tabs';
  @override
  _TabBarTestState createState() => _TabBarTestState();
}

class _TabBarTestState extends State<TabBarTest>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 8, vsync: this);
    super.initState();
  }

  int _selectedIndex = 0;
  final padding = 8.0;
  String? routeArgs;
  String? brand;
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context)!.settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs!.substring(1, 2),
    );

    if (_selectedIndex == 0) {
      setState(() {
        brand = 'Wine';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'Vodka';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'Beer';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brand = 'Rum';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brand = 'Whiskey';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brand = 'Brandy';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brand = 'Cognac';
      });
    }
    if (_selectedIndex == 7) {
      setState(() {
        brand = 'All';
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) return true;
        setState(() {
          _selectedIndex = 0;
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(brand.toString()),
        ),
        body: Column(
          children: [
            ContentSpace(context, brand!),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              if (_selectedIndex == 0) {
                setState(() {
                  brand = 'Wine';
                });
              }
              if (_selectedIndex == 1) {
                setState(() {
                  brand = 'Vodka';
                });
              }
              if (_selectedIndex == 2) {
                setState(() {
                  brand = 'Beer';
                });
              }
              if (_selectedIndex == 3) {
                setState(() {
                  brand = 'Rum';
                });
              }
              if (_selectedIndex == 4) {
                setState(() {
                  brand = 'Whiskey';
                });
              }
              if (_selectedIndex == 5) {
                setState(() {
                  brand = 'Brandy';
                });
              }
              if (_selectedIndex == 6) {
                setState(() {
                  brand = 'Cognac';
                });
              }
              if (_selectedIndex == 7) {
                setState(() {
                  brand = 'All';
                });
              }
            });
          },
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 0,
              ),
              label: 'Wine',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 0,
              ),
              label: 'Vodka',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 0,
              ),
              label: 'Beer',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 0,
              ),
              label: 'Rum',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 0,
              ),
              label: 'Whiskey',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 0,
              ),
              label: 'Brandy',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 0,
              ),
              label: 'Cognac',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 0,
              ),
              label: 'All',
            ),
          ],
        ),
      ),
    );
  }
}
