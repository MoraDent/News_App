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
      create: (BuildContext context) => NewsCubit(),
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
            floatingActionButton: FloatingActionButton(onPressed: ()
            {
              DioHelper.getData(
                  url: 'v2/top-headlines',
                  query: {
                    'country':'eg',
                    'category':'business',
                    'apiKey':'65f7f556ec76449fa7dc7c0069f040ca',
                  },
              ).then((value) {
                print(value.data.toString());
              }).catchError((error) {
                print(error.toString());
              });
            },
            child: Icon(
                Icons.add,
              color: Colors.white,
            ),),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.cahngeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}
