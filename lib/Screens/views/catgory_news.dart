import 'package:agroscan/Screens/helper/news.dart';
import 'package:agroscan/Screens/views/widget/searchbar.dart';
import 'package:flutter/material.dart';

import '../modal/artical_modal.dart';
import 'widget/blog_tile.dart';

class CatgoryNewsPage extends StatefulWidget {
  const CatgoryNewsPage({Key? key, @required this.catgoryname})
      : super(key: key);
  final catgoryname;
  @override
  _CatgoryNewsPageState createState() => _CatgoryNewsPageState();
}

class _CatgoryNewsPageState extends State<CatgoryNewsPage> {
  List<ArticalModel> articalsnews = [];
  bool _loding = true;
  bool _folded = true;
  @override
  void initState() {
    super.initState();
    grtNews();
  }

  grtNews() async {
    CategoryNewsClass newsclass = CategoryNewsClass();
    await newsclass.getNews(widget.catgoryname.toString().toLowerCase());
    articalsnews = newsclass.news;
    setState(() {
      _loding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("News", style: TextStyle(color: Colors.black)),
                Text(
                  "App",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Icon(Icons.save),
            )),
          ),
          Opacity(
            opacity: 0,
            child: Container(
                child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Icon(Icons.save),
            )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(),
            _loding
                ? Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      child: ListView.builder(
                        itemCount: articalsnews.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            title: articalsnews[index].title,
                            img: articalsnews[index].urlToImage,
                            dec: articalsnews[index].description,
                            url: articalsnews[index].url,
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
