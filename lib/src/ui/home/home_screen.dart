import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/bloc/home/home_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app/src/model/category/category.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);
    double paddingTop = mediaQuery.padding.top;

    return Scaffold(
        body: BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF006064),
                      borderRadius: BorderRadius.only(
//                        bottomLeft: Radius.circular(20),
                          )),
                  padding: EdgeInsets.only(
                    top: paddingTop + 16.0,
                    bottom: 16.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          WidgetTitle(strToday),
                        ],
                      ),
                      SizedBox(height: 12.0),
                      WidgetCategory(),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                _buildWidgetLabelLatestNews(context),
                _buildWidgetSubtitleLatestNews(context),
                Expanded(
                  child: WidgetLatestNews(),
                )
              ],
            )));
  }

  Widget _buildWidgetSubtitleLatestNews(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          'Top stories at the moment',
          style: Theme.of(context).textTheme.caption.merge(
                TextStyle(
                  color: Color(0xFF9E9E9E).withOpacity(0.8),
                ),
              ),
        ));
  }

  Widget _buildWidgetLabelLatestNews(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'US News',
        style: Theme.of(context).textTheme.subtitle.merge(
              TextStyle(
                fontSize: 18.0,
                color: Color(0xFF006064).withOpacity(0.8),
              ),
            ),
      ),
    );
  }

  String getStrToday() {
    var today = DateFormat().add_yMMMMd().format(DateTime.now());
    var strDay = today.split(' ')[1].replaceFirst(',', '');
    if (strDay == '1') {
      strDay = strDay + 'st';
    } else if (strDay == '2') {
      strDay = strDay + 'nd';
    } else if (strDay == '3') {
      strDay = strDay + 'rd';
    } else {
      strDay = strDay + 'th';
    }
    var strMonth = today.split(' ')[0];
    var strYear = today.split(' ')[2];
    return '$strDay $strMonth $strYear';
  }
}

class WidgetTitle extends StatelessWidget {
  final String strToday;

  WidgetTitle(this.strToday);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'The Goat News\n',
                style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                        color: Color(0xFFE0F7FA),
                      ),
                    ),
              ),
              TextSpan(
                text: strToday,
                style: Theme.of(context).textTheme.caption.merge(
                      TextStyle(
                        color: Color(0xFFE0F7FA).withOpacity(0.8),
                        fontSize: 10.0,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetCategory extends StatefulWidget {
  @override
  _WidgetCategoryState createState() => _WidgetCategoryState();
}

class _WidgetCategoryState extends State<WidgetCategory> {
  final listCategories = [
    Category('', 'Top'),
    Category('assets/images/img_business.png', 'Business'),
    Category('assets/images/img_entertainment.png', 'Pop Culture'),
    Category('assets/images/img_health.png', 'Health'),
    Category('assets/images/img_science.png', 'Science'),
    Category('assets/images/img_sport.png', 'Sports'),
    Category('assets/images/img_technology.png', 'Technology')
  ];
  int indexSelectedCategory = 0;

  @override
  void initState() {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(DataEvent(listCategories[indexSelectedCategory].title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Container(
      height: 74.0,
      child: ListView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Category itemCategory = listCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: index == listCategories.length - 1 ? 16.0 : 0.0,
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexSelectedCategory = index;
                      homeBloc.add(DataEvent(
                          listCategories[indexSelectedCategory].title));
                    });
                  },
                  child: index == 0
                      ? Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFBDCDDE),
                            border: indexSelectedCategory == index
                                ? Border.all(
                                    color: Color(0xFF006064),
                                    width: 5.0,
                                  )
                                : null,
                          ),
                          child: Icon(
                            Icons.apps,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(itemCategory.image),
                              fit: BoxFit.cover,
                            ),
                            border: indexSelectedCategory == index
                                ? Border.all(
                                    color: Color(0xFF006064), width: 5.0)
                                : null,
                          ),
                        ),
                ),
                SizedBox(height: 8.0),
                Text(
                  itemCategory.title,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFFE0F7FA),
                    fontWeight: indexSelectedCategory == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: listCategories.length,
      ),
    );
    return Container();
  }
}

class WidgetLatestNews extends StatefulWidget {
  WidgetLatestNews();

  @override
  _WidgetLatestNewsState createState() => _WidgetLatestNewsState();
}

class _WidgetLatestNewsState extends State<WidgetLatestNews> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);
    return Padding(
      padding: EdgeInsets.only(
          left: 16.0,
          top: 8.0,
          right: 16.0,
          bottom: mediaQuery.padding.bottom + 16.0),
      child: BlocListener<HomeBloc, DataState>(
          listener: (context, state) {
            //TODO: do something here
          },
          child: BlocBuilder(
            bloc: homeBloc,
            builder: (context, state) {
              return _buildWidgetContentLatestNews(state, mediaQuery);
            },
          )),
    );
  }

  Widget _buildWidgetContentLatestNews(
      DataState state, MediaQueryData mediaQuery) {
    if (state is DataLoading) {
      return Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator()
              : CupertinoActivityIndicator());
    } else if (state is DataSuccess) {
      return Container(
          child: Center(
        child: Text('data success'),
      ));
    } else {
      return Container();
    }
  }
}
