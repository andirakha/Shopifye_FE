import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import "package:flutter/material.dart";
import 'package:shopifye_e_commerce/pages/catalogue_page.dart';
import 'package:shopifye_e_commerce/pages/category_page.dart';
import 'package:shopifye_e_commerce/pages/trolley_page.dart';
import "package:shopifye_e_commerce/pages/user_page.dart";

class AppBarNavBar extends StatefulWidget {
  AppBarNavBar({super.key});

  @override
  State<AppBarNavBar> createState() => _AppBarNavBarState();
}

class _AppBarNavBarState extends State<AppBarNavBar> {
  int indexPage = 0;
  String selectedCategory = '';

  void setValue(String selectedValue) {
    if (selectedValue == 'DRESS') {
      indexPage = 3;
    } else if (selectedValue == 'BAG') {
      indexPage = 4;
    } else if (selectedValue == 'ACCESSORIES') {
      indexPage = 5;
    } else if (selectedValue == 'FOOTWEAR') {
      indexPage = 6;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xffdbb9c7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(84),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            title: Image.asset(
              'lib/assets/logo.png',
              scale: 2.5,
            ),
            actions: [
              IconButton(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage('lib/assets/search.png'),
                  color: Color(0xffac2c62),
                ),
              ),
              SizedBox(width: 20),
              IconButton(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage('lib/assets/chat.png'),
                  color: Color(0xffac2c62),
                ),
              ),
              SizedBox(width: 20),
              IconButton(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const WishlistPage(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                icon: ImageIcon(
                  AssetImage('lib/assets/trolley.png'),
                  color: Color(0xffac2c62),
                ),
              ),
              SizedBox(width: 10),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: <Color>[
                    Colors.white,
                    Colors.white.withAlpha(0),
                  ],
                  stops: [0.67, 1],
                ),
              ),
            ),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Color(0xffAC2C62),
          items: [
            TabItem(
                icon: ImageIcon(
                  AssetImage('lib/assets/home.png'),
                  color: Color((indexPage != 0 ? 0xffDAA0B8 : 0xffAC2C62)),
                ),
                title: 'Home'),
            TabItem(
                icon: ImageIcon(
                  AssetImage('lib/assets/catalogue.png'),
                  color: Color((indexPage != 1 &&
                          indexPage != 3 &&
                          indexPage != 4 &&
                          indexPage != 5 &&
                          indexPage != 6
                      ? 0xffDAA0B8
                      : 0xffAC2C62)),
                ),
                title: 'Catalogue'),
            TabItem(
                icon: ImageIcon(
                  AssetImage('lib/assets/user.png'),
                  color: Color((indexPage != 2 ? 0xffDAA0B8 : 0xffAC2C62)),
                ),
                title: 'User'),
          ],
          onTap: (index) {
            setState(() {
              indexPage = index;
            });
          },
        ),
        body: getSelectedPage(indexPage: indexPage));
  }

  Widget getSelectedPage({required int indexPage}) {
    Widget widget;
    switch (indexPage) {
      case 0:
        widget = HomePage();
        break;
      case 1:
        widget = CategoryPage(
          selectedCategory: (String val) => setState(
            () {
              selectedCategory = val;
              setValue(selectedCategory);
            },
          ),
        );
        break;
      case 2:
        widget = UserPage();
        break;
      case 3:
        widget = DressPage();
        break;
      case 4:
        widget = BagPage();
        break;
      case 5:
        widget = AccessoriesPage();
        break;
      case 6:
        widget = FootwearPage();
        break;
      default:
        widget = HomePage();
        break;
    }
    return widget;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String text = "This is home page";
  List category = ["DRESS", "BAG", "ACCESSORIES", "FOOTWEAR"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Wrap(
              children: category.map((a_category) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: (MediaQuery.of(context).size.width / 2) - 30,
                  decoration: BoxDecoration(
                    color: Color(0xffE9FFE1),
                  ),
                  child: Column(
                    children: [
                      UnconstrainedBox(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          height: (MediaQuery.of(context).size.width / 2) - 60,
                          width: (MediaQuery.of(context).size.width / 2) - 60,
                          decoration: BoxDecoration(
                            color: Color(0xffADD79E),
                          ),
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/shopifye-e5e59.appspot.com/o/Accessories%2FUntitled89_20231225193953.png?alt=media&token=e320ad5e-6a07-4d8b-8e07-0e42e275fd91'),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                        child: Text(
                          'Nama Produk',
                          style: TextStyle(
                            fontFamily: 'Nirmala',
                            fontWeight: FontWeight.w900,
                            color: Color(0xff8A1B63),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 15),
                                child: Text(
                                  'Rp 25.000',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontFamily: 'Leelawadee',
                                    fontSize: 20,
                                    color: Color(0xff2F7318),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 15, 15),
                                child: Image(
                                  image: AssetImage(
                                    'lib/assets/not_liked.png',
                                  ),
                                  width: 40,
                                  height: 40,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}
