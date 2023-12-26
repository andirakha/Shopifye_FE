import "package:flutter/material.dart";

class DressPage extends StatefulWidget {
  const DressPage({super.key});

  @override
  State<DressPage> createState() => _DressPageState();
}

class _DressPageState extends State<DressPage> {
  String text = "This is dress page";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  String text = "This is bag page";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class AccessoriesPage extends StatefulWidget {
  const AccessoriesPage({super.key});

  @override
  State<AccessoriesPage> createState() => _AccessoriesPageState();
}

class _AccessoriesPageState extends State<AccessoriesPage> {
  String text = "This is accessories page";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class FootwearPage extends StatefulWidget {
  const FootwearPage({super.key});

  @override
  State<FootwearPage> createState() => _FootwearPageState();
}

class _FootwearPageState extends State<FootwearPage> {
  String text = "This is footwear page";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
