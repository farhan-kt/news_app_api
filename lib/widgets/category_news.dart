// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_api/model/categories_news_model.dart';
import 'package:news_app_api/view/category_details_screen.dart';
import 'package:news_app_api/view_model/news_view_model.dart';

NewsViewModel newsViewModel = NewsViewModel();
final format = DateFormat('MMMM dd, yyyy');
Padding category_news(Size mediaQuery) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: FutureBuilder<CategoriesNewsModel>(
      future: newsViewModel.fetchCategoriesNews('General'),
      builder:
          (BuildContext context, AsyncSnapshot<CategoriesNewsModel> snapshot) {
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
        } else if (!snapshot.hasData || snapshot.data!.articles == null) {
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
                              content: snapshot.data!.articles![index].content
                                  .toString(),
                              source: snapshot
                                  .data!.articles![index].source!.name
                                  .toString())));
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
                          placeholder: (context, url) => const Center(
                            child: SpinKitFadingCircle(
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
  );
}
