import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/screens/home_page_tab.dart';

class NewEventPage extends StatefulWidget {
  final Event event;

  NewEventPage({@required this.event});

  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewEventPage> {
  City _selectCity;
  Category _selectCategory;
  DateTime _dateTime;
  final _email = TextEditingController();
  final _errorMessage = TextEditingController();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _peopleNeeded = TextEditingController();

  List<City> _cities = [
    City(id: 1, name: 'Plovdiv'),
    City(id: 2, name: 'Sofia')
  ];

  List<Category> _categories = [
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
    _errorMessage.text = "";

    if (widget.event != null) {
      _email.text = widget.event.createdByUser.userName;
      _name.text = widget.event.title;
      _description.text = widget.event.description;
      _peopleNeeded.text = widget.event.peopleNeeded;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New event"),
      ),
      body: Stack(
        children: <Widget>[
          _showForm(),
        ],
      ),
    );
  }

  Widget _showForm() {
    return new Container(
//      padding: EdgeInsets.all(16.0),
      child: new Form(
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showTitleInput(),
            _showCategoryDropDown(),
            _showDateInput(),
            _showCitiesDropDown(),
            _showPeopleInput(),
            _showDescription(),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            _saveButtonBar(context),
            _showErrorMessage(),
          ],
        ),
      ),
    );
  }

  GestureDetector _saveButtonBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_name.text.isEmpty) {
          print("Event validation failed!");
          return;
        } else {
//          _createOrder(_email.text,_phoneNumber.text,_name.text,_description.text,_placeLocation);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePageTab()));
        }
      },
      child: Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SAVE",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget _showCategoryDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: DropdownButton(
              hint:
                  Text('Please choose a category', textAlign: TextAlign.center),
              // Not necessary for Option 1
              value: _selectCategory,
              onChanged: (newValue) {
                setState(() {
                  _selectCategory = newValue;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: new Text(
                    category.name,
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showCitiesDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: DropdownButton(

              hint: Text('Please choose the city', textAlign: TextAlign.center),
              // Not necessary for Option 1
              value: _selectCity,
              onChanged: (newValue) {
                setState(() {
                  _selectCity = newValue;
                });
              },
              items: _cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: new Text(
                    city.name,
                    textAlign: TextAlign.center,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _showTitleInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: _name,
        decoration: new InputDecoration(
            hintText: 'Title',
            icon: new Icon(
              Icons.text_fields,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
        onSaved: (value) => _name.text = value.trim(),
      ),
    );
  }

  Widget _showPeopleInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.number,
        autofocus: false,
        controller: _peopleNeeded,
        decoration: new InputDecoration(
            hintText: 'People needed',
            icon: new Icon(
              Icons.person_add,
              color: Colors.grey,
            )),
        validator: (value) =>
            value.isEmpty ? 'People needed can\'t be empty' : null,
        onSaved: (value) => _peopleNeeded.text = value.trim(),
      ),
    );
  }

  Widget _showDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: _description,
        decoration: new InputDecoration(
            hintText: 'Description',
            icon: new Icon(
              Icons.message,
              color: Colors.grey,
            )),
        onSaved: (value) => _description.text = value.trim(),
      ),
    );
  }

  Widget _showDateInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.only(top: 35),
          onPressed: () {
            DatePicker.showDateTimePicker(context,
                showTitleActions: true,
                minTime: DateTime.now(),
                maxTime: DateTime(2025, 1, 1, 1, 2), onChanged: (date) {
              print('change $date');
              _dateTime = date;
            }, onConfirm: (date) {
              print('confirm $date');
              _dateTime = date;
            }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Choose date & time",
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.calendar_today,
                size: 35,
              ),
              Icon(
                Icons.access_time,
                size: 35,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showErrorMessage() {
    if (_errorMessage.text.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage.text,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1, 1, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            currentTime.hour,
            currentTime.minute,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            currentTime.hour,
            currentTime.minute,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
