import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_api/controller/home_provider.dart';
import 'package:news_app_api/model/news_headline_model.dart';
import 'package:news_app_api/view/categories_screen.dart';
import 'package:news_app_api/widgets/category_news.dart';
import 'package:news_app_api/view/news_detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()));
            },
            icon: const Icon(Icons.menu)),
        title: Text(
          'NEWS',
          style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Consumer<HomeProvider>(
            builder: (context, value, child) => PopupMenuButton<FiltereList>(
                initialValue: value.selectedItem,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                onSelected: (FiltereList item) {
                  if (FiltereList.bbcNews.name == item.name) {
                    value.name = 'bbc-news';
                  }
                  if (FiltereList.aryNews.name == item.name) {
                    value.name = 'ary-news';
                  }
                  if (FiltereList.aljazeera.name == item.name) {
                    value.name = 'al-jazeera-english';
                  }
                  value.selectedItems(item);
                },
                itemBuilder: (context) => <PopupMenuEntry<FiltereList>>[
                      const PopupMenuItem<FiltereList>(
                          value: FiltereList.bbcNews, child: Text('BBC NEWS')),
                      const PopupMenuItem<FiltereList>(
                          value: FiltereList.aryNews, child: Text(' ARY NEWS')),
                      const PopupMenuItem<FiltereList>(
                          value: FiltereList.aljazeera,
                          child: Text(' AL-JAZEERA')),
                    ]),
          )
        ],
      ),
      body: ListView(
        children: [
          Consumer<HomeProvider>(
            builder: (context, value, child) => SizedBox(
              height: mediaQuery.height * 0.5,
              width: mediaQuery.width * double.infinity,
              child: FutureBuilder<NewsHeadlineModel>(
                  future: newsViewModel.fetchNewsChannelHeadline(value.name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SpinKitFadingCircle(
                              color: Colors.grey, size: 30));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsDetailScreen(
                                            newsImage: snapshot.data!
                                                .articles![index].urlToImage
                                                .toString(),
                                            newsTitle: snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            newsDate: snapshot.data!
                                                .articles![index].publishedAt
                                                .toString(),
                                            author: snapshot
                                                .data!.articles![index].author
                                                .toString(),
                                            description: snapshot.data!
                                                .articles![index].description
                                                .toString(),
                                            content:
                                                snapshot.data!.articles![index].content.toString(),
                                            source: snapshot.data!.articles![index].source!.name.toString())));
                              },
                              child: SizedBox(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: mediaQuery.height * 0.6,
                                      width: mediaQuery.width * 0.9,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: mediaQuery.height * 0.02),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(child: spinKit),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error_outline_outlined,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.bottomCenter,
                                          height: mediaQuery.height * 0.22,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: mediaQuery.width * 0.6,
                                                child: Text(
                                                    snapshot.data!
                                                        .articles![index].title
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  Text(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  SizedBox(
                                                      width: mediaQuery.width *
                                                          0.2),
                                                  Text(format.format(dateTime),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Colors.red,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                  }),
            ),
          ),
          category_news(mediaQuery),
        ],
      ),
    );
  }
}

enum FiltereList { bbcNews, aryNews, independent, reuters, cnn, aljazeera }

const spinKit = SpinKitCircle(
  color: Colors.grey,
  size: 30,
);
