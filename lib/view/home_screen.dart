import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_api/model/categories_news_model.dart';
import 'package:news_app_api/model/news_headline_model.dart';
import 'package:news_app_api/view/categories_screen.dart';
import 'package:news_app_api/view/category_details_screen.dart';
import 'package:news_app_api/view/news_detail_screen.dart';
import 'package:news_app_api/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FiltereList { bbcNews, aryNews, independent, reuters, cnn, aljazeera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FiltereList? selectedItem;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoriesScreen()));
            },
            icon: const Icon(Icons.menu)),
        title: Text(
          'NEWS',
          style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<FiltereList>(
              initialValue: selectedItem,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FiltereList item) {
                if (FiltereList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FiltereList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                if (FiltereList.aljazeera.name == item.name) {
                  name = 'al-jazeera-english';
                }
                setState(() {
                  selectedItem = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FiltereList>>[
                    const PopupMenuItem<FiltereList>(
                        value: FiltereList.bbcNews, child: Text('BBC NEWS')),
                    const PopupMenuItem<FiltereList>(
                        value: FiltereList.aryNews, child: Text(' ARY NEWS')),
                    const PopupMenuItem<FiltereList>(
                        value: FiltereList.aljazeera,
                        child: Text(' AL-JAZEERA')),
                  ])
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: mediaQuery.height * 0.5,
            width: mediaQuery.width * double.infinity,
            child: FutureBuilder<NewsHeadlineModel>(
                future: newsViewModel.fetchNewsChannelHeadline(name),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            SpinKitFadingCircle(color: Colors.grey, size: 30));
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
                                          newsImage: snapshot
                                              .data!.articles![index].urlToImage
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                    width:
                                                        mediaQuery.width * 0.2),
                                                Text(format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.red,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600)),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNews('General'),
              builder: (BuildContext context,
                  AsyncSnapshot<CategoriesNewsModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.grey,
                      size: 30,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.articles == null) {
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var article = snapshot.data!.articles![index];
                      DateTime dateTime = DateTime.parse(article.publishedAt!);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryDetailScreen(
                                      newsImage: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      newsTitle: snapshot.data!.articles![index].title
                                          .toString(),
                                      newsDate: snapshot
                                          .data!.articles![index].publishedAt
                                          .toString(),
                                      author: snapshot.data!.articles![index].author
                                          .toString(),
                                      description: snapshot
                                          .data!.articles![index].description
                                          .toString(),
                                      content: snapshot
                                          .data!.articles![index].content
                                          .toString(),
                                      source: snapshot.data!.articles![index].source!.name.toString())));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: article.urlToImage ?? '',
                                  fit: BoxFit.cover,
                                  height: mediaQuery.height * 0.18,
                                  width: mediaQuery.width * 0.3,
                                  placeholder: (context, url) => Container(
                                    child: const Center(
                                      child: SpinKitFadingCircle(
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  height: mediaQuery.height * 0.18,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ?? '',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        article.source!.name ?? '',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        format.format(dateTime),
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spinKit = SpinKitCircle(
  color: Colors.grey,
  size: 30,
);
