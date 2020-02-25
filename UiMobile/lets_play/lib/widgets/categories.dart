import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/screens/subcategory_screen.dart';
import 'package:lets_play/services/categoryFilter.dart';
import 'package:lets_play/widgets/event_list.dart';

class CategoryWidget extends StatefulWidget {

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Category category;
  List<Category> categories = [
    Category(id: 1, name: 'Sport', categoryIcon: Icons.directions_run),
    Category(
        id: 5,
        name: 'Handball',
        categoryIcon: Icons.directions_run,
        parentId: 1),
    Category(id: 2, name: 'Video Games', categoryIcon: Icons.videogame_asset),
    Category(id: 3, name: 'Board Games', categoryIcon: Icons.table_chart),
    Category(id: 4, name: 'Tourism', categoryIcon: Icons.card_travel),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories
                .where((data) => data.parentId == null)
                .map((data) => _buildCategoryItem(data, categories))
                .toList(),
          ),
        ),
       //EventList()
      ],
    );
  }

  Widget _buildCategoryItem(Category category, List<Category> categories) {
    List<Category> subCategories = categories
        .where((data) => data.parentId != null && data.parentId == category.id)
        .toList();
    return CategoryListItem(
        categoryIcon: category.categoryIcon,
        categoryName: category.name,
        selected: false,
        subCategories: subCategories,
        category: category);
  }
}

class CategoryListItem extends StatefulWidget {
  final IconData categoryIcon;
  final String categoryName;
  bool selected;
  final List<Category> subCategories;
  final Category category;

  CategoryListItem(
      {@required this.categoryIcon,
      @required this.categoryName,
      @required this.selected,
      @required this.subCategories,
      @required this.category});

  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SubCategory(
                    subCategories: widget.subCategories,
                    parentCategory: widget.category,
                  )),
        );
      },
      onTap: () {
        if (widget.selected) {
          setState(() {
            widget.selected = false;
          });
        } else {
          setState(() {
            widget.selected = true;
          });
        }

        print(widget.selected);
      },
      child: Container(
        //margin: EdgeInsets.only(right: 20),
        margin: EdgeInsets.fromLTRB(0, 6, 5, 2),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: widget.selected ? Color(0xfffeb324) : Colors.white,
            border: Border.all(
                color: widget.selected ? Colors.transparent : Colors.grey[200],
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
                      color: widget.selected ? Colors.transparent : Colors.grey,
                      width: 1.5)),
              child: Icon(
                widget.categoryIcon,
                color: Colors.black,
                size: 30,
              ),
            ),
            Text(
              widget.categoryName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
