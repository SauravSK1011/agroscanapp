import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'modal/artical_modal.dart';
import 'views/widget/blog_tile.dart';

class NewsPage extends StatefulWidget {
  NewsPage({super.key, required this.articalsnews});
  List<ArticalModel> articalsnews = [];

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("NEWS"),),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(126, 217, 87, 1),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  child: ListView.builder(
                    itemCount: widget.articalsnews.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        title: widget.articalsnews[index].title,
                        img: widget.articalsnews[index].urlToImage,
                        dec: widget.articalsnews[index].description,
                        url: widget.articalsnews[index].url,
                      );
                    },
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
