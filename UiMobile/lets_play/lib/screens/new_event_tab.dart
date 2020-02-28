import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/enums/repeating_enum.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/screens/home_page_tab.dart';
import 'package:lets_play/widgets/new_category.dart';

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
  final _exactAddress = TextEditingController();
  bool _isRepeating = false;
  int _repeatingPeriod;

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
      _peopleNeeded.text = widget.event.peopleNeeded.toString();
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
            _showExactAddressInput(),
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
          //create Event and UserEvent
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

  void _addNewCategory(Category selectCategory, String name) {

    final category = Category(id: _categories.length+1 ,categoryIcon: Icons.category, name: name, parentId: selectCategory.id);
    setState(() {
        _categories.add(category);
    });
  }

  void _startAddNewCategory(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GestureDetector(
                onTap: () {},
                child: NewCategory(_addNewCategory, _categories),
                behavior: HitTestBehavior.opaque,
              ));
        });
  }

  Widget _showCategoryDropDown() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
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
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child:
//                          ExpansionTile(
//                            title: Text("Expansion Title"),
//                            children: <Widget>[Text("children 1"), Text("children 2")],
//                          ),
                      new Text(
                        category.name,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAddNewCategory(context),
                )
              ],
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

  Widget _showExactAddressInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: _exactAddress,
        decoration: new InputDecoration(
            hintText: 'Exact address',
            icon: new Icon(
              Icons.add_location,
              color: Colors.grey,
            )),
        onSaved: (value) => _exactAddress.text = value.trim(),
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
              setState(() {
                _dateTime = date;
              });
            }, onConfirm: (date) {
              print('confirm $date');
              setState(() {
                _dateTime = date;
              });
            }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                _dateTime == null
                    ? "Choose date & time"
                    : DateFormat('yyyy-MM-dd – kk:mm').format(_dateTime),
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
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _isRepeating
                ? DropdownButton(
                    hint: Text('Please choose a period',
                        textAlign: TextAlign.center),
                    // Not necessary for Option 1
                    value: _repeatingPeriod,
                    onChanged: (newValue) {
                      setState(() {
                        _repeatingPeriod = newValue;
                      });
                    },
                    items: Repeating.values.map((repeat) {
                      return DropdownMenuItem(
                        value: repeat.index,
                        child: new Text(
                          EnumToString.parse(repeat),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  )
                : Text("Repeating off"),
            Switch(
              value: _isRepeating,
              onChanged: (value) {
                print(value);
                setState(() {
                  _isRepeating = value;
                  if (!value) {
                    _repeatingPeriod = null;
                  }
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        )
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
