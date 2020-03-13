import 'package:flutter/material.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/services/category_service.dart';

class NewCategory extends StatefulWidget {
  final Function addCategory;
  final List<Category> categories;

  NewCategory(this.addCategory, this.categories);

  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  List<Category> _parentCategories ;
  final _categoryNameController = TextEditingController();
  Category _selectCategory;

  @override
  void initState() {
    _parentCategories = this.widget.categories.where((category) => category.parentId == 1).toList();
    super.initState();
  }
  void _submitData() async {
    if (_selectCategory == null && _categoryNameController.text.isEmpty) {
      return;
    }
    final enteredName = _categoryNameController.text;
    final enteredCategory = _selectCategory;

    print(enteredCategory);

    if (enteredName.isEmpty) {
      return;
    }
    final category = Category(
        categoryIcon: Icons.category,
        name: enteredName,
        parentId: enteredCategory.id);
    widget.addCategory(category);
    setState(() {
      widget.categories.add(category);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _showCategoryDropDown(),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                decoration: InputDecoration(labelText: 'Subcategory name'),
                controller: _categoryNameController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _submitData,
              ),
            ),
            RaisedButton(
              child: Text('Add Category'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _showCategoryDropDown() {
    return Column(
      children: <Widget>[
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DropdownButton(
                hint: Text('Please choose a category',
                    textAlign: TextAlign.center),
                // Not necessary for Option 1
                value: _selectCategory,
                onChanged: (newValue) {
                  setState(() {
                    _selectCategory = newValue;
                  });
                },
                items: _parentCategories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: new Text(
                      category.name,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
