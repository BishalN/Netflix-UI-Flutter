import 'package:flutter/material.dart';

import '../assets.dart';
import '../widgets/responsive.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({this.scrollOffset = 0.0});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        color: Colors.black
            .withOpacity((scrollOffset / 350).clamp(0, 1).toDouble()),
        child: Responsive(
          desktop: _CustomAppBarDesktop(),
          mobile: _CustomAppBarMobile(),
        ));
  }
}

class _CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(
                    title: 'Tv Shows', onTap: () => print('Tv shows')),
                _AppBarButton(title: 'Movies', onTap: () => print('Movies')),
                _AppBarButton(title: 'My List', onTap: () => print('My List'))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: 'Home', onTap: () => print('Home')),
                _AppBarButton(
                    title: 'Tv Shows', onTap: () => print('Tv shows')),
                _AppBarButton(title: 'Latest', onTap: () => print('Latest')),
                _AppBarButton(title: 'Movies', onTap: () => print('Movies')),
                _AppBarButton(title: 'My List', onTap: () => print('My List')),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () => print('search')),
                _AppBarButton(title: 'KIDS', onTap: () => print('KIDS')),
                _AppBarButton(title: 'DVD', onTap: () => print('DVD')),
                IconButton(
                    icon: Icon(
                      Icons.card_giftcard,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () => print('GiftCard')),
                IconButton(
                    icon: Icon(
                      Icons.notifications,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () => print('notifications')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const _AppBarButton({@required this.title, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ));
  }
}
