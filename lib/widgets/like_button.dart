import 'package:assignment/providers/word_list_provider.dart';
import 'package:assignment/utils/constants.dart';
import 'package:assignment/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CustomLikeButton extends StatefulWidget {
  final bool? isInWishlist;
  final String word;
  CustomLikeButton({
    super.key,
    this.isInWishlist,
    required this.word,
   });

  @override
  State<CustomLikeButton> createState() => _CustomLikeButtonState();
}


class _CustomLikeButtonState extends State<CustomLikeButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isAnimatingForward = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _isAnimatingForward = widget.isInWishlist ?? false;
    if (_isAnimatingForward) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_isAnimatingForward) {
          _animationController.reverse();
          Provider.of<WordListProvider>(context, listen: false)
              .removeFromWishlist(widget.word);
        } else {
          _animationController.forward();
          Provider.of<WordListProvider>(context, listen: false)
              .addToWishlist(widget.word);
              toastMessage(text: 'Item added to wishlist', context: context);

        }
        _isAnimatingForward = !_isAnimatingForward;
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: Lottie.asset(
          likeAnimation,
          fit: BoxFit.fill,
          repeat: false,
          controller: _animationController,
        ),
      ),
    );
  }
}
