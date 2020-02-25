import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';

class CategoryWidget extends StatelessWidget {
  List<Category> categories = [Category(name: 'Sport',categoryIcon: Icons.directions_run), Category(name: 'Video Games', categoryIcon: Icons.videogame_asset), Category(name: 'Board Games', categoryIcon: Icons.table_chart)];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories
            .map((data) => _buildCategoryItem(data))
            .toList(),
      ),
    );
  }

  Widget _buildCategoryItem(Category category) {

    return CategoryListItem(
      categoryIcon: category.categoryIcon,
      categoryName: category.name,
      selected: false,
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final IconData categoryIcon;
  final String categoryName;
  final bool selected;

  CategoryListItem(
      {@required this.categoryIcon,
      @required this.categoryName,
      @required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: selected ? Color(0xfffeb324) : Colors.white,
          border: Border.all(
              color: selected ? Colors.transparent : Colors.grey[200],
              width: 1.5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[100],
                blurRadius: 15,
                offset: Offset(10, 0),
                spreadRadius: 5)
          ]),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey,
                    width: 1.5)),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 30,
            ),
          ),
          Text(
            categoryName,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
