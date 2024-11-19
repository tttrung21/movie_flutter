import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_movie_app/features/detail/detail_screen.dart';
import 'package:simple_movie_app/model/list_movie_model.dart';
import 'package:simple_movie_app/shared/constant.dart';
import 'package:simple_movie_app/style/color_style.dart';
import 'package:simple_movie_app/style/text_style.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.item});

  final Results? item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailScreen(id: item?.id ?? 0),
        ));
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 120,
              width: 100,
              imageUrl: Constant.imgUrl + (item?.posterPath ?? ''),
              errorWidget: (context, url, error) {
                return Image.asset('assets/images/placeholder.jpg');
              },
              placeholder: (context, url) {
                return Image.asset('assets/images/placeholder.jpg');
              },
              fadeInCurve: Curves.linear,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item?.title ?? '',
                    style: ModTextStyle.itemTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Column(
                    children: [
                      buildDetail(
                          CupertinoIcons.ticket, item?.voteAverage?.toStringAsFixed(2), true),
                      const SizedBox(
                        height: 8,
                      ),
                      buildDetail(Icons.calendar_today_outlined, item?.releaseDate),
                      const SizedBox(
                        height: 8,
                      ),
                      buildDetail(Icons.language, item?.originalLanguage),
                      const SizedBox(
                        height: 8,
                      ),
                      buildDetail(Icons.score, item?.popularity?.toStringAsFixed(2))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDetail(IconData icon, String? data, [bool isRating = false]) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: isRating ? ModColorStyle.rating : ModColorStyle.white1,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          data ?? '',
          style: ModTextStyle.itemDetail.copyWith(
              color: isRating ? ModColorStyle.rating : ModColorStyle.white1,
              fontWeight: isRating ? FontWeight.w600 : FontWeight.w400),
        )
      ],
    );
  }
}
