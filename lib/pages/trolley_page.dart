import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:shopifye_e_commerce/controllers/product_controller.dart";
import "package:shopifye_e_commerce/models/product.dart";
import "package:shopifye_e_commerce/pages/ordered.dart";

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<Product> products;
  late List<Product> filteredProducts;
  List checkout_status = [];
  List quantity = [];
  List like_status = [];
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  final currentUser = FirebaseAuth.instance.currentUser!;
  dynamic firestoreData;

  @override
  void initState() {
    super.initState();
    products = [];
    getData();
    getFirestoreData();
  }

  void filteredList(List liked_status) {
    setState(() {
      filteredProducts = products.where((product) {
        return liked_status[product.id - 1] == true;
      }).toList();
    });
  }

  Future<dynamic> getFirestoreData() async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("Users").doc(currentUser.email);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        firestoreData = snapshot.data()! as Map<String, dynamic>;
      });
    });
  }

  Future<void> getData() async {
    final List<Product> data = await getProducts();
    if (mounted) {
      setState(
        () {
          products = data;
        },
      );
    }
  }

  Future<void> setQuantity(List quantity) async {
    await usersCollection.doc(currentUser.email).update(
      {'quantitywishlist': quantity},
    );
  }

  Future<void> toggleCheckoutStatus(List checkout_status) async {
    await usersCollection.doc(currentUser.email).update(
      {'checkouted': checkout_status},
    );
  }

  @override
  Widget build(BuildContext context) {
    if (products.length == 0 || firestoreData == null) {
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
          body: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
            ),
          ));
    } else {
      quantity = firestoreData['quantitywishlist'];
      checkout_status = firestoreData['checkouted'];
      like_status = firestoreData['likestatus'];
      filteredList(like_status);
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
                  SizedBox(height: 55),
                  Wrap(
                    children: [
                      for (int index = 0;
                          index < filteredProducts.length;
                          index++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 25),
                            decoration: BoxDecoration(
                              color: Color(0xffBF8AA0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          checkout_status[
                                              filteredProducts[index].id -
                                                  1] = !checkout_status[
                                              filteredProducts[index].id - 1];
                                          toggleCheckoutStatus(checkout_status);
                                        });
                                      },
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Image(
                                          image: AssetImage(firestoreData[
                                                          'checkouted'][
                                                      filteredProducts[index]
                                                              .id -
                                                          1] ==
                                                  false
                                              ? 'lib/assets/unselected.png'
                                              : 'lib/assets/selected.png'),
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  color: Color(0xffADD79E),
                                  height: 70,
                                  width: 70,
                                  child: Image.network(
                                      filteredProducts[index].photo),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(20),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredProducts[index].nama,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Leelawadee',
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        Text(
                                          'Rp ' +
                                              filteredProducts[index]
                                                  .harga
                                                  .toString(),
                                          style: TextStyle(
                                            color: Color(0xffAC2C62),
                                            fontFamily: 'Leelawadee',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 5, 20),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            quantity[
                                                filteredProducts[index].id -
                                                    1] += 1;
                                            setQuantity(quantity);
                                          });
                                        },
                                        child: Image(
                                          image:
                                              AssetImage('lib/assets/up.png'),
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (quantity[
                                                    filteredProducts[index].id -
                                                        1] !=
                                                1) {
                                              quantity[
                                                  filteredProducts[index].id -
                                                      1] -= 1;
                                              setQuantity(quantity);
                                            }
                                          });
                                        },
                                        child: Image(
                                          image:
                                              AssetImage('lib/assets/down.png'),
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 20, 20),
                                  child: Column(
                                    children: [
                                      Text(
                                        quantity[filteredProducts[index].id - 1]
                                            .toString(),
                                        style: TextStyle(
                                          color: Color(0xffAC2C62),
                                          fontFamily: 'Leelawadee',
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        SizedBox(height: 55),
                        GestureDetector(
                          onTap: () {
                            if (checkout_status
                                .any((element) => element == true)) {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
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
                            }
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
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late List<Product> products;
  late List<Product> filteredProducts;
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");
  num totalCost = 0;
  List checkout_status = [];
  List quantity = [];
  List like_status = [];
  dynamic firestoreData;

  @override
  void initState() {
    super.initState();
    products = [];
    getData();
    getFirestoreData();
  }

  Future<dynamic> getFirestoreData() async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("Users").doc(currentUser.email);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        firestoreData = snapshot.data()! as Map<String, dynamic>;
      });
    });
  }

  Future<void> getData() async {
    final List<Product> data = await getProducts();
    if (mounted) {
      setState(
        () {
          products = data;
        },
      );
    }
  }

  void filteredList(List checkout_status) {
    setState(() {
      filteredProducts = products.where((product) {
        return checkout_status[product.id - 1] == true;
      }).toList();
    });
  }

  num setTotalCost(num totalcost) {
    for (int index = 0; index < filteredProducts.length; index++) {
      totalcost = totalcost +
          (filteredProducts[index].harga *
              quantity[filteredProducts[index].id - 1]);
    }
    return totalcost;
  }

  Future<void> resetValue(
      List quantity, List checkout_status, List like_status) async {
    await usersCollection.doc(currentUser.email).update(
      {
        'quantitywishlist': quantity,
        'likestatus': like_status,
        'checkouted': checkout_status,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (products.length == 0 || firestoreData == null) {
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
                'Checkout',
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
          body: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
            ),
          ));
    } else {
      quantity = firestoreData['quantitywishlist'];
      checkout_status = firestoreData['checkouted'];
      like_status = firestoreData['likestatus'];
      filteredList(checkout_status);
      totalCost = setTotalCost(totalCost);
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
              color: Color(0xffADD79E),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 4,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xffAC2C62))),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product Total',
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  color: Color(0xffac2c62),
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rp ' + totalCost.toString(),
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  color: Color(0xffac2c62),
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Delivery',
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  color: Color(0xffac2c62),
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rp 10000',
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  color: Color(0xffac2c62),
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 4,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Color(0xffAC2C62))),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  color: Color(0xffac2c62),
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rp ' + (totalCost + 10000).toString(),
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  color: Color(0xffac2c62),
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async => {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
                      ),
                    );
                  },
                ),
                await Future.delayed(const Duration(seconds: 2)),
                setState(() {
                  for (int index = 0;
                      index < filteredProducts.length;
                      index++) {
                    quantity[filteredProducts[index].id - 1] = 1;
                    like_status[filteredProducts[index].id - 1] = false;
                    checkout_status[filteredProducts[index].id - 1] = false;
                  }
                  resetValue(quantity, checkout_status, like_status);
                }),
                Navigator.pop(context),
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const PaymentSuccessfulPage(),
                  ),
                ),
              },
              child: Container(
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
            ),
          ],
        ),
      );
    }
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
      for (int index = 0; index < filteredProducts.length; index++)
        DataRow(cells: [
          DataCell(
            Text(
              filteredProducts[index].nama,
              style: TextStyle(
                fontFamily: 'Leelawadee',
                color: Color(0xffac2c62),
                fontSize: 15,
              ),
            ),
          ),
          DataCell(
            Text(
              quantity[filteredProducts[index].id - 1].toString(),
              style: TextStyle(
                fontFamily: 'Leelawadee',
                color: Color(0xffac2c62),
                fontSize: 15,
              ),
            ),
          ),
          DataCell(
            Text(
              (filteredProducts[index].harga *
                      quantity[filteredProducts[index].id - 1])
                  .toString(),
              style: TextStyle(
                fontFamily: 'Leelawadee',
                color: Color(0xffac2c62),
                fontSize: 15,
              ),
            ),
          )
        ]),
    ];
  }
}
