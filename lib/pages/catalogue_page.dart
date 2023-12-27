import "package:flutter/material.dart";
import "package:shopifye_e_commerce/controllers/product_controller.dart";
import "package:shopifye_e_commerce/models/product.dart";

class DressPage extends StatefulWidget {
  const DressPage({super.key});

  @override
  State<DressPage> createState() => _DressPageState();
}

class _DressPageState extends State<DressPage> {
  late List<Product> products;
  late List<Product> filteredProducts;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    products = [];
    getData();
  }

  void filteredList() {
    setState(() {
      filteredProducts = products.where((product) {
        final choosedCategory = product.kategori;
        final choosedCatalogue = 'Dress';
        return choosedCategory.contains(choosedCatalogue);
      }).toList();
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

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (products.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
        ),
      );
    } else {
      filteredList();
      return SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 135,
              ),
              Text(
                'DRESS',
                style: TextStyle(
                    fontFamily: 'LucidaFax',
                    fontSize: 35,
                    color: Color(0xff681136),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 40,
              ),
              Wrap(
                children: [
                  for (int index = 0; index < filteredProducts.length; index++)
                    Container(
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
                              height:
                                  (MediaQuery.of(context).size.width / 2) - 60,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 60,
                              decoration: BoxDecoration(
                                color: Color(0xffADD79E),
                              ),
                              child:
                                  Image.network(filteredProducts[index].photo),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                            child: Text(
                              filteredProducts[index].nama,
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
                                      'Rp ' +
                                          filteredProducts[index]
                                              .harga
                                              .toString(),
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
                    )
                ],
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
}

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  late List<Product> products;
  late List<Product> filteredProducts;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    products = [];
    getData();
  }

  void filteredList() {
    setState(() {
      filteredProducts = products.where((product) {
        final choosedCategory = product.kategori;
        final choosedCatalogue = 'Bag';
        return choosedCategory.contains(choosedCatalogue);
      }).toList();
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

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (products.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
        ),
      );
    } else {
      filteredList();
      return SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 135,
              ),
              Text(
                'BAG',
                style: TextStyle(
                    fontFamily: 'LucidaFax',
                    fontSize: 35,
                    color: Color(0xff681136),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 40,
              ),
              Wrap(
                children: [
                  for (int index = 0; index < filteredProducts.length; index++)
                    Container(
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
                              height:
                                  (MediaQuery.of(context).size.width / 2) - 60,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 60,
                              decoration: BoxDecoration(
                                color: Color(0xffADD79E),
                              ),
                              child:
                                  Image.network(filteredProducts[index].photo),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                            child: Text(
                              filteredProducts[index].nama,
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
                                      'Rp ' +
                                          filteredProducts[index]
                                              .harga
                                              .toString(),
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
                    )
                ],
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
}

class AccessoriesPage extends StatefulWidget {
  const AccessoriesPage({super.key});

  @override
  State<AccessoriesPage> createState() => _AccessoriesPageState();
}

class _AccessoriesPageState extends State<AccessoriesPage> {
  late List<Product> products;
  late List<Product> filteredProducts;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    products = [];
    getData();
  }

  void filteredList() {
    setState(() {
      filteredProducts = products.where((product) {
        final choosedCategory = product.kategori;
        final choosedCatalogue = 'Accessories';
        return choosedCategory.contains(choosedCatalogue);
      }).toList();
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

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (products.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
        ),
      );
    } else {
      filteredList();
      return SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 135,
              ),
              Text(
                'ACCESSORIES',
                style: TextStyle(
                    fontFamily: 'LucidaFax',
                    fontSize: 35,
                    color: Color(0xff681136),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 40,
              ),
              Wrap(
                children: [
                  for (int index = 0; index < filteredProducts.length; index++)
                    Container(
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
                              height:
                                  (MediaQuery.of(context).size.width / 2) - 60,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 60,
                              decoration: BoxDecoration(
                                color: Color(0xffADD79E),
                              ),
                              child:
                                  Image.network(filteredProducts[index].photo),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                            child: Text(
                              filteredProducts[index].nama,
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
                                      'Rp ' +
                                          filteredProducts[index]
                                              .harga
                                              .toString(),
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
                    )
                ],
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
}

class FootwearPage extends StatefulWidget {
  const FootwearPage({super.key});

  @override
  State<FootwearPage> createState() => _FootwearPageState();
}

class _FootwearPageState extends State<FootwearPage> {
  late List<Product> products;
  late List<Product> filteredProducts;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    products = [];
    getData();
  }

  void filteredList() {
    setState(() {
      filteredProducts = products.where((product) {
        final choosedCategory = product.kategori;
        final choosedCatalogue = 'Footwear';
        return choosedCategory.contains(choosedCatalogue);
      }).toList();
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

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (products.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
        ),
      );
    } else {
      filteredList();
      return SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 135,
              ),
              Text(
                'FOOTWEAR',
                style: TextStyle(
                    fontFamily: 'LucidaFax',
                    fontSize: 35,
                    color: Color(0xff681136),
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 40,
              ),
              Wrap(
                children: [
                  for (int index = 0; index < filteredProducts.length; index++)
                    Container(
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
                              height:
                                  (MediaQuery.of(context).size.width / 2) - 60,
                              width:
                                  (MediaQuery.of(context).size.width / 2) - 60,
                              decoration: BoxDecoration(
                                color: Color(0xffADD79E),
                              ),
                              child:
                                  Image.network(filteredProducts[index].photo),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
                            child: Text(
                              filteredProducts[index].nama,
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
                                      'Rp ' +
                                          filteredProducts[index]
                                              .harga
                                              .toString(),
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
                    )
                ],
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
}
