import "package:flutter/material.dart";

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xffdbb9c7),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(84),
          child: AppBar(
            leading: BackButton(color: Color(0xffac2c62)),
            backgroundColor: Colors.transparent,
            elevation: 0,
            shadowColor: Colors.transparent,
            title: Text(
              'Wishlist',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'ErasDemiITC',
                color: Color(0xffac2c62),
              ),
            ),
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
        body: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Wishlist',
                    style: TextStyle(
                      color: Color(0xffAC2C62),
                      fontFamily: 'Leelawadee',
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 55),
                  SizedBox(
                    width: double.infinity,
                    height: 4,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xffAC2C62))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        SizedBox(height: 55),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const CheckoutPage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
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
                          child: UnconstrainedBox(
                            child: Container(
                              height: 60,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Color(0xffAC2C62),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: UnconstrainedBox(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 55,
                                  width: 175,
                                  // color: Color(0xffB3D3A3),
                                  decoration: BoxDecoration(
                                    color: Color(0xffB3D3A3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'CHECK OUT',
                                    style: TextStyle(
                                      color: Color(0xffAC2C62),
                                      fontFamily: 'Leelawadee',
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffdbb9c7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(84),
        child: AppBar(
          leading: BackButton(color: Color(0xffac2c62)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          title: Text(
            'Check Out',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'ErasDemiITC',
              color: Color(0xffac2c62),
            ),
          ),
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
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  'Check Out',
                  style: TextStyle(
                    color: Color(0xffAC2C62),
                    fontFamily: 'Leelawadee',
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 55),
                SizedBox(
                  width: double.infinity,
                  height: 4,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xffAC2C62))),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          Container(
            color: Color(0xffADD79E),
            child: checkoutList(),
          ),
          Container(
            alignment: Alignment.bottomRight,
            color: Color(0xffADD79E),
            height: MediaQuery.of(context).size.height - 420,
            child: UnconstrainedBox(
              child: Container(
                margin: EdgeInsets.all(25),
                alignment: Alignment.center,
                height: 50,
                width: 160,
                decoration: BoxDecoration(
                  color: Color(0xffA96682),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'BUY',
                  style: TextStyle(
                    color: Color(0xffE9FFE1),
                    fontFamily: 'Leelawadee',
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataTable checkoutList() {
    return DataTable(
      headingRowColor:
          MaterialStateColor.resolveWith((states) => Color(0xffdbb9c7)),
      dataRowMaxHeight: 60,
      columns: _createColumns(),
      rows: _createRows(),
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Text(
          'Product',
          style: TextStyle(
            fontFamily: 'Leelawadee',
            color: Color(0xffA96682),
            fontSize: 18,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          'Qty',
          style: TextStyle(
            fontFamily: 'Leelawadee',
            color: Color(0xffA96682),
            fontSize: 18,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          '@Pcs',
          style: TextStyle(
            fontFamily: 'Leelawadee',
            color: Color(0xffA96682),
            fontSize: 18,
          ),
        ),
      )
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('#100')),
        DataCell(Text('Flutter Basics\nFlutter Basics')),
        DataCell(Text('David John'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('Alex Wick'))
      ])
    ];
  }
}
