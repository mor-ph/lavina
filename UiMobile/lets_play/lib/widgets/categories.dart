import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/bloc/category/category_event.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/screens/subcategory_screen.dart';
import 'package:lets_play/widgets/event_list.dart';
import 'package:provider/provider.dart';

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
    Category(
        id: 5,
        name: 'Monopolia',
        categoryIcon: Icons.directions_run,
        parentId: 3),
    Category(
        id: 6,
        name: 'Football',
        categoryIcon: Icons.directions_run,
        parentId: 1),
    Category(id: 3, name: 'Board Games', categoryIcon: Icons.table_chart),
    Category(id: 4, name: 'Tourism', categoryIcon: Icons.card_travel),
  ];

  @override
  void initState() {
    categories.forEach((category) => category.isSelected = false);
    super.initState();
  }

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
        subCategories: subCategories,
        category: category);
  }
}

class CategoryListItem extends StatefulWidget {
  final IconData categoryIcon;
  final String categoryName;
  final List<Category> subCategories;
  final Category category;

  CategoryListItem(
      {@required this.categoryIcon,
      @required this.categoryName,
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
      onTap: () async {
        if (widget.category.isSelected) {
          setState(() {
            widget.category.isSelected = false;
          });
        } else {
          setState(() {
            widget.category.isSelected = true;
          });

          BlocProvider.of<CategoryBloc>(context)
              .add(CategorySelectedEvent(category: widget.category));
        }

        print(widget.category.isSelected);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 6, 5, 2),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color:
                widget.category.isSelected ? Color(0xfffeb324) : Colors.white,
            border: Border.all(
                color: widget.category.isSelected
                    ? Colors.transparent
                    : Colors.grey[200],
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
                      color: widget.category.isSelected
                          ? Colors.transparent
                          : Colors.grey,
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
