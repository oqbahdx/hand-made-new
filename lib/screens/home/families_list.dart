import 'package:flutter/material.dart';


class FamiliesList extends StatefulWidget {
  const FamiliesList({Key? key}) : super(key: key);

  @override
  _FamiliesListState createState() => _FamiliesListState();
}

class _FamiliesListState extends State<FamiliesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('FamiliesList'),),
    );
  }
}