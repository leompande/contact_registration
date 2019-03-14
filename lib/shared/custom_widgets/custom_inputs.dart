import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget{
  String label;
  Function onSaved;
  CustomInput(this.label, this._controller);
  final TextEditingController _controller;
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: Colors.grey[300])),
        padding: EdgeInsets.only(left: 20.0, bottom: 0.0),
        child: TextFormField(
            autofocus: false,
            controller: _controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: label,)),
      ),
    );
  }
}

class SearchField extends StatelessWidget{
  TextEditingController searchController;
  SearchField(this.searchController);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: Colors.grey[300])),
        padding: EdgeInsets.only(left: 20.0, bottom: 0.0),
        child: TextFormField(
          controller: searchController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',)),
      ),
    );
  }
}