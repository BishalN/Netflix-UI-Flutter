import 'package:flutter/material.dart';

import '../models/models.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Content> contentList;
  final bool isOriginals;
  const ContentList({
    Key key,
    this.title,
    this.contentList,
    this.isOriginals = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: isOriginals ? 555 : 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemCount: contentList.length,
            itemBuilder: (BuildContext context, int index) {
              final Content content = contentList[index];

              return GestureDetector(
                onTap: () => print(content.name),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  height: isOriginals ? 400 : 200,
                  width: isOriginals ? 200 : 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(content.imageUrl),
                          fit: BoxFit.cover)),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
