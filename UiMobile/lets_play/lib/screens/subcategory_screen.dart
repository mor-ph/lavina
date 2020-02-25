import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/widgets/categories.dart';
import 'package:lets_play/widgets/event_list.dart';

class SubCategory extends StatelessWidget {
  final List<Category> subCategories;
  final Category parentCategory;

  SubCategory({@required this.subCategories, @required this.parentCategory});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        parentCategory.name,
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            height: 120,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: subCategories
                  .where((data) => data.parentId != null)
                  .map((data) => _buildCategoryItem(data))
                  .toList(),
            ),
          ),
          EventList(),
        ],
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
