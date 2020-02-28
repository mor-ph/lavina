import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/widgets/categories.dart';
import 'package:lets_play/widgets/event_list.dart';

class SubCategory extends StatelessWidget {
  final List<Category> subCategories;
  final Category parentCategory;
  final bool isSubCategory;

  SubCategory(
      {@required this.subCategories,
      @required this.parentCategory,
      @required this.isSubCategory});

  @override
  Widget build(BuildContext context) {
    if (subCategories == null || subCategories.isEmpty) {
      return Container();
    } else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            height: 70,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: subCategories
                  .where((data) => data.parentId != null)
                  .map((data) => _buildCategoryItem(data))
                  .toList(),
            ),
          ),
        ],
      );
  }

  Widget _buildCategoryItem(Category category) {
    return CategoryListItem(
      categoryIcon: category.categoryIcon,
      categoryName: category.name,
      category: category,
      subCategories: subCategories,
    );
  }
}
