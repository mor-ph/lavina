import 'package:dynamic_treeview/dynamic_treeview.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/enums/repeating_enum.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/screens/home_page_tab.dart';
import 'package:lets_play/services/category_service.dart';
import 'package:lets_play/services/city_service.dart';
import 'package:lets_play/services/event_service.dart';
import 'package:lets_play/widgets/new_category.dart';
import 'package:lets_play/widgets/progress_indicator.dart';

class NewEventPage extends StatefulWidget {
  final Event event;

  NewEventPage({@required this.event});

  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewEventPage> {
  City _selectCity;
  Category _selectedCategory;
  DateTime _dateTime;
  final _email = TextEditingController();
  final _errorMessage = TextEditingController();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _peopleNeeded = TextEditingController();
  final _exactAddress = TextEditingController();
  bool _isRepeating = false;
  int _repeatingPeriod;
  final _formKey = new GlobalKey<FormState>();

  List<City> _cities;

  List<Category> _categories;

  getCities() async {
    List<City> cities = await CityService.getCities();
    if (cities != null) {
      setState(() {
        _cities = cities;
      });
    }
  }

  getCategories() async {
    List<Category> category = await CategoryService.getCategories();
    if (category != null) {
      setState(() {
        _categories = category;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _errorMessage.text = "";

    if (widget.event != null) {
      _email.text = widget.event.createdByUser.userName;
      _name.text = widget.event.title;
      _description.text = widget.event.description;
      _peopleNeeded.text = widget.event.peopleNeeded.toString();
    }
//    getCities();
//    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/lavina-logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text('Lavina'))
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          _showForm(context),
        ],
      ),
    );
  }

  Widget _showForm(context) {
    return new Container(
//      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            _showTitleInput(),
            _showCategory(),
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
      onTap: () async {
        if (!validateAndSave() ||
            _name.text.isEmpty ||
            _peopleNeeded.text.isEmpty) {
          final snackbar = SnackBar(
            content: Text("Event validation failed!"),
            duration: Duration(milliseconds: 900),
          );
          Scaffold.of(context).showSnackBar(snackbar);
          return Text("Event validation failed!");
        } else {
          bool isSuccess = await EventService.createEvent(new Event(
            exactAddress: _exactAddress.text,
            category: _selectedCategory,
            city: _selectCity,
            description: _description.text,
            peopleNeeded: int.parse(_peopleNeeded.text),
            recurring: _repeatingPeriod,
            startDate: _dateTime,
            title: _name.text,
          ));
          SnackBar snackbar;
          if (isSuccess) {
            snackbar = SnackBar(
              content: Text("Event successfully created!"),
              duration: Duration(milliseconds: 900),
            );
            _resetForm();
          } else {
            snackbar = SnackBar(
              content: Text("Event didn't created!"),
              duration: Duration(milliseconds: 900),
            );
          }
          Scaffold.of(context).showSnackBar(snackbar);

          return HomePageTab();
        }
      },
      child: Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
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

  Widget _showCategory() {
    if (_categories == null) {
      getCategories();
      return ProgressIndicatorWidget();
    }
    return Form(
      child: FlatButton(
        padding: EdgeInsets.only(top: 35),
        onPressed: () => _categoriesTree(),
        child: _selectedCategory == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Please choose a category",
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.category,
                    size: 35,
                    color: Theme.of(context).buttonColor,
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "You category is: ",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    _selectedCategory.name,
                    style: TextStyle(color: Theme.of(context).buttonColor),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Icon(
                    Icons.category,
                    size: 35,
                    color: Theme.of(context).buttonColor,
                  ),
                ],
              ),
      ),
    );
  }

  // ignore: missing_return
  Widget _categoriesTree() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Categories"),
            ),
            body: DynamicTreeView(
              data: _categories, // pass here List<BaseModel>
              config: Config(
                  parentTextStyle: TextStyle(
                      color: Theme.of(context).buttonColor, fontWeight: FontWeight.w600),
                  rootId: "1",
                  parentPaddingEdgeInsets:
                      EdgeInsets.only(left: 16, top: 0, bottom: 0)),
              onTap: (m) {
                print("tapped");
                Category category;
                try {
                  category = m['extra']['key'];
                } catch (e) {
                  print(e);
                  category =
                      _categories.firstWhere((c) => c.id == int.parse(m['id']));
                }

                setState(() {
                  _selectedCategory = category;
                });
                Navigator.of(context).pop();
              },
              width: MediaQuery.of(context).size.width,
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              heroTag: Text('Approve'),
              backgroundColor: Theme.of(context).buttonColor,
              onPressed: () => _startAddNewCategory(context),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        });
  }

  void _addNewCategory(Category selectCategory) {
    setState(() {
      _categories.add(selectCategory);
    });
    CategoryService.createCategory(selectCategory);
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

  Widget _showCitiesDropDown() {
    if (_cities == null) {
      getCities();
      return ProgressIndicatorWidget();
    }
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
              color: Theme.of(context).buttonColor,
            )),
        validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
        onSaved: (value) => _name.text = value.trim(),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (_selectCity == null) {
      return false;
    }

    if (_selectedCategory == null) {
      return false;
    }

    if (_dateTime == null) {
      return false;
    }
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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
              color: Theme.of(context).buttonColor,
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
        validator: (value) =>
            value.isEmpty ? 'People needed can\'t be empty' : null,
        decoration: new InputDecoration(
            hintText: 'Description',
            icon: new Icon(
              Icons.message,
              color: Theme.of(context).buttonColor,
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
              color: Theme.of(context).buttonColor,
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
                color: Theme.of(context).buttonColor,
              ),
              Icon(
                Icons.access_time,
                size: 35,
                color: Theme.of(context).buttonColor,
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
              hoverColor: Theme.of(context).buttonColor,
              focusColor: Theme.of(context).buttonColor,
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          ],
        )
      ],
    );
  }

  void _resetForm() {
    _formKey.currentState.reset();
//    _errorMessage = "";
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
