import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../models/models.dart';
import './widgets.dart';
import './responsive.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;
  ContentHeader({this.featuredContent});
  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: _ContentHeaderMobile(featuredContent: featuredContent),
        desktop: _ContentHeaderDesktop(featuredContent: featuredContent));
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({Key key, this.featuredContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(featuredContent.imageUrl), fit: BoxFit.cover),
          ),
        ),
        Container(
          height: 400,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        Positioned(
          bottom: 110,
          child: SizedBox(
            width: 250,
            child: Image.asset(featuredContent.titleImageUrl),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: 'MyList',
                onTap: () => print('My list'),
              ),
              _PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: 'Info',
                onTap: () => print('Info'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({Key key, this.featuredContent})
      : super(key: key);

  @override
  __ContentHeaderDesktopState createState() => __ContentHeaderDesktopState();
}

class __ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  VideoPlayerController _videoPlayerController;
  bool _isMuted = true;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl)
          ..initialize().then((_) => setState(() {}))
          ..play()
          ..setVolume(0);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _videoPlayerController.value.isPlaying
          ? _videoPlayerController.pause
          : _videoPlayerController.play,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController.value.initialized
                ? _videoPlayerController.value.aspectRatio
                : 2.344,
            child: _videoPlayerController.value.initialized
                ? VideoPlayer(_videoPlayerController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            left: 0,
            bottom: -1,
            right: 0,
            child: AspectRatio(
              aspectRatio: _videoPlayerController.value.initialized
                  ? _videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
              ),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250,
                  child: Image.asset(widget.featuredContent.titleImageUrl),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.featuredContent.description,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 6)
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    _PlayButton(),
                    const SizedBox(width: 16),
                    FlatButton.icon(
                        padding: EdgeInsets.fromLTRB(20, 10, 30, 10),
                        color: Colors.white,
                        onPressed: () => print('More Info'),
                        icon: const Icon(
                          Icons.info_outline,
                          size: 30.0,
                        ),
                        label: const Text(
                          'More Info',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(width: 20),
                    if (_videoPlayerController.value.initialized)
                      IconButton(
                          icon: _isMuted
                              ? Icon(
                                  Icons.volume_off,
                                  color: Colors.white,
                                )
                              : Icon(Icons.volume_up, color: Colors.white),
                          onPressed: () => {
                                setState(() {
                                  _isMuted
                                      ? _videoPlayerController.setVolume(100)
                                      : _videoPlayerController.setVolume(0);
                                  _isMuted =
                                      _videoPlayerController.value.volume == 0;
                                })
                              })
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      padding: !Responsive.isDesktop(context)
          ? EdgeInsets.fromLTRB(15, 5, 20, 5)
          : EdgeInsets.fromLTRB(20, 10, 30, 10),
      onPressed: () => print('Play'),
      color: Colors.white,
      icon: const Icon(
        Icons.play_arrow,
        size: 30.0,
      ),
      label: const Text(
        'Play',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
