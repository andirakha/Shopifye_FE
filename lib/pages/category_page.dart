import "package:flutter/material.dart";

class CategoryPage extends StatefulWidget {
  final Function(String) selectedCategory;
  CategoryPage({super.key, required this.selectedCategory});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List category = ["DRESS", "BAG", "ACCESSORIES", "FOOTWEAR"];
  String text = "This is catalogue page";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 135,
              ),
              Text(
                'CATEGORY',
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
                children: category.map((a_category) {
                  return GestureDetector(
                    onTap: () => widget.selectedCategory(a_category),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xffB9527D),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      height: (MediaQuery.of(context).size.width / 2) - 30,
                      width: (MediaQuery.of(context).size.width / 2) - 30,
                      child: Text(
                        a_category,
                        style: TextStyle(
                            fontFamily: 'LucidaFax',
                            fontSize: 20,
                            color: Color(0xff681136),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          )),
    );
  }
}
