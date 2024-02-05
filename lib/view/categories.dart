import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_api/model/categories_news_model.dart';
import 'package:news_app_api/view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// class _CategoriesScreenState extends State<CategoriesScreen> {
//   NewsViewModel newsViewModel = NewsViewModel();

//   final format = DateFormat('MMMM dd, yyyy');
//   String categoryName = 'General';

//   List<String> categoriesList = [
//     'General',
//     'Entertainment',
//     'Health',
//     'Sports',
//     'Business',
//     'Technology'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     Size mediaQuery = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 50,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: categoriesList.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         categoryName = categoriesList[index];
//                         setState(() {});
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.only(right: 12),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: categoryName == categoriesList[index]
//                                   ? Colors.blue
//                                   : Colors.grey,
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Center(
//                                 child: Text(
//                               categoriesList[index].toString(),
//                               style: GoogleFonts.poppins(
//                                 fontSize: 13,
//                               ),
//                             )),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: FutureBuilder<CategoriesNewsModel>(
//                   future: newsViewModel.fetchCategoriesNews(categoryName),
//                   builder: (BuildContext context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                           child: SpinKitFadingCircle(
//                               color: Colors.grey, size: 30));
//                     } else {
//                       return ListView.builder(
//                           itemCount: snapshot.data!.articles!.length,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (context, index) {
//                             DateTime dateTime = DateTime.parse(snapshot
//                                 .data!.articles![index].publishedAt
//                                 .toString());
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 15),
//                               child: Row(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(15),
//                                     child: CachedNetworkImage(
//                                       imageUrl: snapshot
//                                           .data!.articles![index].urlToImage
//                                           .toString(),
//                                       fit: BoxFit.cover,
//                                       height: mediaQuery.height * 0.18,
//                                       width: mediaQuery.width * 0.3,
//                                       placeholder: (context, url) => Container(
//                                           child: Center(
//                                               child: SpinKitFadingCircle(
//                                                   color: Colors.grey,
//                                                   size: 30))),
//                                       errorWidget: (context, url, error) =>
//                                           Icon(
//                                         Icons.error_outline_outlined,
//                                         color: Colors.red,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                       child: Container(
//                                     padding: EdgeInsets.only(left: 15),
//                                     height: mediaQuery.height * 0.18,
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           snapshot.data!.articles![index].title
//                                               .toString(),
//                                           maxLines: 3,
//                                           style: GoogleFonts.poppins(
//                                               color: Colors.grey,
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                         Spacer(),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(
//                                               snapshot.data!.articles![index]
//                                                   .source!.name
//                                                   .toString(),
//                                               style: GoogleFonts.poppins(
//                                                   color: Colors.grey,
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                             Text(
//                                               format.format(dateTime),
//                                               style: GoogleFonts.poppins(
//                                                   color: Colors.grey,
//                                                   fontSize: 15,
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ))
//                                 ],
//                               ),
//                             );
//                           });
//                     }
//                   }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = categoriesList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName == categoriesList[index]
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                            child: Text(
                              categoriesList[index].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNews(categoryName),
                builder: (BuildContext context,
                    AsyncSnapshot<CategoriesNewsModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
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
                    return Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var article = snapshot.data!.articles![index];
                        DateTime dateTime =
                            DateTime.parse(article.publishedAt!);
                        return Padding(
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
                                    child: Center(
                                      child: SpinKitFadingCircle(
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error_outline_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 15),
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
                                      Spacer(),
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
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
