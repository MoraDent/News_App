import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/setting_screen/settings_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

import '../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_volleyball,
        ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index == 1) {
      getSports();
    }
    if(index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }


  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'api/v4/top-headlines',
      query: {
        'q': 'business',
        'lang': 'ar',
        'country': 'eg',
        'token': '0caa8d6fe5ac10ef917823f2336a987b',
      },
    ).then((value) {
      print("Full API Response: ${value.data}");
      business = value.data['articles'] ?? [];
      if (business.isNotEmpty) {
        print("First article title: ${business[0]['title']}");
        emit(NewsGetBusinessSuccessState());
      } else {
        print("No articles found in response");
        emit(NewsGetBusinessErrorState("No articles available"));
      }
    }).catchError((error) {
      print("Error fetching business news: ${error.toString()}");
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0)
      {
        DioHelper.getData(
          url: 'api/v4/top-headlines',
          query: {
            'q': 'sports',
            'lang': 'ar',
            'country': 'eg',
            'token': '0caa8d6fe5ac10ef917823f2336a987b',
          },
        ).then((value) {
          sports = value.data['articles'];
          print(sports[0]['title']);

          emit(NewsGetSportsSuccessState());
        }).catchError((error) {
          print(error.toString());
          emit(NewsGetSportsErrorState(error.toString()));
        });
      } else
        {
          emit(NewsGetSportsSuccessState());
        }
  }


  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0)
    {
      DioHelper.getData(
        url: 'api/v4/top-headlines',
        query: {
          'q': 'science',
          'lang': 'ar',
          'country': 'eg',
          'token': '0caa8d6fe5ac10ef917823f2336a987b',
        },
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetScienceSuccessState());
    }
  }


}
