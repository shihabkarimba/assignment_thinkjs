import 'package:assignment/providers/word_list_provider.dart';
import 'package:assignment/utils/constants.dart';
import 'package:assignment/widgets/like_button.dart';
import 'package:assignment/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class BuildWords extends StatefulWidget {
  const BuildWords({super.key});

  @override
  State<BuildWords> createState() => _BuildWordsState();
}

class _BuildWordsState extends State<BuildWords> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordListProvider>(
      builder: (context, wordListProvider, child) {
        final words = wordListProvider.wordList;

        if (words.isEmpty) {
          return Expanded(
            child: Center(
              child: Lottie.asset(emptyAnimation),
            ),
          );
        }

        return Expanded(
          child: ListView.separated(
            itemCount: words.length,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              bool isInWishlist = false;
              if(wordListProvider.wishlist.contains(words[index])){
                isInWishlist = true;
              }
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
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
                              isInWishlist: isInWishlist,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    final _textController =
                                        TextEditingController();
                                    customShowDialog(
                                      context: context,
                                      textController: _textController,
                                      onButtonPressed: () {
                                        String newWord = _textController.text;
                                        Provider.of<WordListProvider>(context,
                                                listen: false)
                                            .editWord(index, newWord);
                                        Navigator.of(context).pop();
                                      },
                                      header: 'Edit the word',
                                      textButton: 'Edit',
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<WordListProvider>(context,
                                            listen: false)
                                        .deleteWord(index);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            )
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
    );
  }
}
