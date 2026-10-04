import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PromotionImageCarousel extends StatefulWidget {
  const PromotionImageCarousel({
    super.key,
    required this.imageUrls,
    this.fit = BoxFit.contain,
    this.indicatorColor = Colors.white,
    this.backgroundColor = const Color(0xFFF4F7F7),
  });

  final List<String> imageUrls;
  final BoxFit fit;
  final Color indicatorColor;
  final Color backgroundColor;

  @override
  State<PromotionImageCarousel> createState() => _PromotionImageCarouselState();
}

class _PromotionImageCarouselState extends State<PromotionImageCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrls.isEmpty) {
      return ColoredBox(
        color: widget.backgroundColor,
        child: const Center(child: Icon(Icons.image_not_supported_outlined)),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.imageUrls.length,
          onPageChanged: (page) => setState(() => _currentPage = page),
          itemBuilder: (context, index) => CachedNetworkImage(
            imageUrl: widget.imageUrls[index],
            fit: widget.fit,
            placeholder: (context, url) => ColoredBox(
              color: widget.backgroundColor,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => ColoredBox(
              color: widget.backgroundColor,
              child: const Center(
                child: Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),
        ),
        if (widget.imageUrls.length > 1)
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Semantics(
              label: 'Image ${_currentPage + 1} of ${widget.imageUrls.length}',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  widget.imageUrls.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: index == _currentPage ? 16 : 7,
                    height: 7,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: widget.indicatorColor.withOpacity(
                        index == _currentPage ? 0.95 : 0.55,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
