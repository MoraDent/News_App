import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          var cubit = NewsCubit.get(context);

          return  Scaffold(
            appBar: AppBar(
              title: Text(
                'News App',
              ),
              actions: [
                IconButton(
                  onPressed: ()
                  {

                  },
                  icon: Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}
