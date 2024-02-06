import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatelessWidget {
  final String newsImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;
  NewsDetailScreen(
      {super.key,
      required this.newsImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.content,
      required this.source});
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.parse(newsDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: mediaQuery.height * 0.4,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: CachedNetworkImage(
                imageUrl: newsImage,
                fit: BoxFit.cover,
                placeholder: (context, ulr) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Container(
            height: mediaQuery.height * 0.6,
            margin: EdgeInsets.only(top: mediaQuery.height * 0.4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                Text(
                  newsTitle,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(source,
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                    Text(format.format(dateTime),
                        style: GoogleFonts.poppins(
                            fontSize: 13, fontWeight: FontWeight.w500))
                  ],
                ),
                SizedBox(
                  height: mediaQuery.height * 0.03,
                ),
                Text(description,
                    style: GoogleFonts.poppins(
                        fontSize: 13, fontWeight: FontWeight.w400))
              ],
            ),
          )
        ],
      ),
    );
  }
}
