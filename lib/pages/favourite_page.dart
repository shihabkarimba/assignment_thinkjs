import 'package:assignment/providers/word_list_provider.dart';
import 'package:assignment/utils/constants.dart';
import 'package:assignment/widgets/like_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavouratePage extends StatelessWidget {
  const FavouratePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(73, 244, 67, 54),
            Color.fromARGB(83, 255, 235, 59),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Consumer<WordListProvider>(
            builder: (context, wordListProvider, child) {
              final words = wordListProvider.wishlist;

              if (words.isEmpty) {
                return Center(
                  child: Lottie.asset(emptyAnimation),
                );
              }

              return Expanded(
                child: ListView.separated(
                  itemCount: words.length,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(words[index]),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomLikeButton(
                                    word: words[index],
                                    isInWishlist: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
