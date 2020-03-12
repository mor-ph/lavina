import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lets_play/bloc/category/category_bloc.dart';
import 'package:lets_play/bloc/category/category_state.dart';
import 'package:lets_play/model/category.dart';
import 'package:lets_play/model/city.dart';
import 'package:lets_play/model/event.dart';
import 'package:lets_play/model/user.dart';
import 'package:lets_play/screens/subcategory_screen.dart';
import 'package:lets_play/services/event_service.dart';
import 'package:lets_play/widgets/categories.dart';
import 'package:lets_play/widgets/event_list.dart';
import 'package:lets_play/widgets/progress_indicator.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomePageTab extends StatefulWidget {
  @override
  _HomePageTabState createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab> {
  List<Event> _events;

  getEvents() async {
    List<Event> events = await EventService.getEvents();
    if(events != null){
      setState(() {
        _events = events;
      });
    }
  }

  @override
  void initState() {
    //getEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_events == null){
      getEvents();
      return ProgressIndicatorWidget();
    }
    return BlocBuilder(
        bloc: BlocProvider.of<CategoryBloc>(context),
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Home page"),
            ),
            body:  Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CategoryWidget(),
                      _eventListByState(state, context),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _eventListByState(state, context) {
    if (state is EventCategoryFetchedState) {
      final List<Event> events = state.events;
      return Column(
        children: <Widget>[
          SubCategory(
              subCategories: state.subCategories,
              parentCategory: state.category,
              isSubCategory: true),
          EventList(events: events)
        ],
      );
    } else if (state is EventCategoryEmptyState) {
      print("emptyState!");
      return Column(children: <Widget>[EventList(events: _events)]);
    }
  }
}
