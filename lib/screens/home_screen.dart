import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/widgets.dart';
import '../data/data.dart';
import '../cubits/app_bar/app_bar_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Cast'),
        child: Icon(Icons.cast),
        backgroundColor: Colors.grey[850],
      ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrolloffset) {
            return CustomAppBar(
              scrollOffset: scrolloffset,
            );
          },
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(featuredContent: sintelContent),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 1),
            sliver: SliverToBoxAdapter(
              child: Previews(
                  key: PageStorageKey('Previews'),
                  title: 'Previews',
                  contentList: previews),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('My List'),
                title: 'My List',
                contentList: myList),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                key: PageStorageKey('Originals'),
                title: 'Netflix Original',
                contentList: originals,
                isOriginals: true),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20),
            sliver: SliverToBoxAdapter(
              child: ContentList(
                  key: PageStorageKey('Trending'),
                  title: 'Trending',
                  contentList: trending),
            ),
          ),
        ],
      ),
    );
  }
}
