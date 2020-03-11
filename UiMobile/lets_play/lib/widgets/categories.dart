import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/bloc/category/category_event.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/screens/subcategory_screen.dart';
import 'package:lets_play/services/category_service.dart';
import 'package:lets_play/widgets/event_list.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Category category;
  List<Category> categories ;
  @override
  void initState() {
    categories = CategoryService.getCategories() as List<Category>;
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
                .where((data) => data.parentId == 1)
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
      subCategories: subCategories == null ? categories : subCategories,
      category: category,
      categories: categories,
    );
  }
}

class CategoryListItem extends StatefulWidget {
  final IconData categoryIcon;
  final String categoryName;
  final List<Category> subCategories;
  final Category category;
  final List<Category> categories;

  CategoryListItem(
      {@required this.categoryIcon,
      @required this.categoryName,
      @required this.subCategories,
      @required this.category,
      @required this.categories});

  @override
  _CategoryListItemState createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.category.isSelected) {
          setState(() {
            widget.category.isSelected = false;
          });
        } else {
          setState(() {
            if (widget.categories != null) {
              widget.categories
                  .where((cat) => cat.isSelected != null && cat.isSelected)
                  .forEach((cat) => cat.isSelected = false);
            }

            if(widget.subCategories != null){
              widget.subCategories
                  .where((cat) => cat.isSelected != null && cat.isSelected)
                  .forEach((cat) => cat.isSelected = false);
            }
            widget.category.isSelected = true;
          });

          BlocProvider.of<CategoryBloc>(context).add(CategorySelectedEvent(
              category: widget.category, subCategories: widget.subCategories));
        }
      },
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.fromLTRB(0, 6, 5, 2),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
            borderRadius: widget.category.parentId != 1
                ? BorderRadius.circular(20)
                : BorderRadius.circular(50),
            color:
                widget.category.isSelected ? Colors.grey[500]: Colors.white,
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
          children: <Widget>[
            Container(
              padding: widget.category.parentId != 1
                  ? EdgeInsets.all(5)
                  : EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: widget.category.parentId != 1
                      ? BorderRadius.circular(20)
                      : BorderRadius.circular(50),
                  border: Border.all(
                      color: widget.category.isSelected
                          ? Colors.transparent
                          : Colors.grey,
                      width: 1.5)),
              child: Icon(
                widget.categoryIcon,
                color: Colors.black,
                size: widget.category.parentId != 1 ? 10 : 30,
              ),
            ),
            Text(
              widget.categoryName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: widget.category.isSelected != 1
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
