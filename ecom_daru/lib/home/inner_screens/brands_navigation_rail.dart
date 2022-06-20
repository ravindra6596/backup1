import 'package:ecom_daru/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brands_rail_widget.dart';

class BrandNavigationRailScreen extends StatefulWidget {
  BrandNavigationRailScreen({Key? key}) : super(key: key);

  static const routeName = '/brands_navigation_rail';
  @override
  _BrandNavigationRailScreenState createState() =>
      _BrandNavigationRailScreenState();
}

class _BrandNavigationRailScreenState extends State<BrandNavigationRailScreen> {
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
    print(routeArgs.toString());
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
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: NavigationRail(
                        minWidth: 40.0,
                        groupAlignment: 1.0,
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: (int index) {
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
                            print(brand);
                          });
                        },
                        labelType: NavigationRailLabelType.all,
                        selectedLabelTextStyle: TextStyle(
                          color: Color(0xffffe6bc97),
                          fontSize: 20,
                          letterSpacing: 1,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2.5,
                        ),
                        unselectedLabelTextStyle: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.8,
                        ),
                        destinations: [
                          buildRotatedTextRailDestination('Wine', padding),
                          buildRotatedTextRailDestination("Vodka", padding),
                          buildRotatedTextRailDestination("Beer", padding),
                          buildRotatedTextRailDestination("Rum", padding),
                          buildRotatedTextRailDestination("Whiskey", padding),
                          buildRotatedTextRailDestination("Brandy", padding),
                          buildRotatedTextRailDestination("Cognac", padding),
                          buildRotatedTextRailDestination("All", padding),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            // This is the main content.

            ContentSpace(context, brand!)
          ],
        ),
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String brand;
  ContentSpace(BuildContext context, this.brand);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final productsBrand = productsData.findByBrand(brand);
    if (brand == 'All') {
      for (int i = 0; i < productsData.product.length; i++) {
        productsBrand.add(productsData.product[i]);
      }
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: productsBrand.length,
            itemBuilder: (BuildContext context, int index) =>
                ChangeNotifierProvider.value(
              value: productsBrand[index],
              child: BrandsNavigationRail(),
            ),
          ),
        ),
      ),
    );
  }
}
