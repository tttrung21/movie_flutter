import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_movie_app/features/home/bloc/home_bloc.dart';
import 'package:simple_movie_app/features/home/movie_item.dart';
import 'package:simple_movie_app/style/color_style.dart';
import 'package:simple_movie_app/style/text_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  void loadMore()  {
    if (_scrollController.position.atEdge) {
      bool isAtTop = _scrollController.position.pixels == 0;
      if (!isAtTop) {
        context.read<HomeBloc>().add(LoadMore());
      }
    }
    // if (_isBottom) {
    //   context.read<HomeBloc>().add(LoadMore());
    // }
  }
  // bool get _isBottom {
  //   if (!_scrollController.hasClients) return false;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.offset;
  //   return currentScroll >= (maxScroll * 0.9);
  // }
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(loadMore);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(loadMore);
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ModColorStyle.primary,
        appBar: AppBar(
          backgroundColor: ModColorStyle.primary,
          elevation: 0,
          title: Text(
            "Movies",
            style: ModTextStyle.title.copyWith(color: ModColorStyle.whiteTitle),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: ModColorStyle.white1,
              ));
            }
            if (state is HomeError) {
              return Center(
                child: Text(
                  state.error,
                  style: ModTextStyle.itemTitle.copyWith(color: ModColorStyle.white1),
                ),
              );
            }
            if (state is HomeSuccess) {
              return RefreshIndicator(
                onRefresh: () async{
                  print('refresh');
                  context.read<HomeBloc>().add(HomeRefreshEvent());
                },
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    final item = state.listMovies[index];
                    return MovieItem(item: item);
                  },
                  itemCount: state.listMovies.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 16,
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ));
  }
}
