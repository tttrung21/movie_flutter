
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_movie_app/features/detail/view_model/detail_viewmodel.dart';
import 'package:simple_movie_app/model/movie_detail.dart';

import '../../shared/constant.dart';
import '../../style/color_style.dart';
import '../../style/text_style.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.id});

  final int id;
  final DetailViewModel detailViewModel = DetailViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ModColorStyle.primary,
      appBar: AppBar(
        backgroundColor: ModColorStyle.primary,
        elevation: 0,
        toolbarHeight: 66,
        leading: const SizedBox(),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: ModColorStyle.white1,
                        size: 20,
                      )),
                  Text(
                    "Detail",
                    style: ModTextStyle.title.copyWith(color: ModColorStyle.whiteTitle),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: ModColorStyle.white1,
                        size: 32,
                      ))
                ],
              ),
            )),
      ),
      body: FutureBuilder(
        future: detailViewModel.fetchMovie(id),
        builder: (context, snapshot) {
          if (detailViewModel.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: ModColorStyle.white1,
            ));
          }
          if (detailViewModel.movie == null && !detailViewModel.isLoading) {
            return Center(
              child: Text(
                'Cannot fetch movie',
                style: ModTextStyle.title.copyWith(color: ModColorStyle.white1),
              ),
            );
          }
          if (detailViewModel.errorMessage != null) {
            return Center(
              child: Text(
                detailViewModel.errorMessage ?? '',
                style: ModTextStyle.title.copyWith(color: ModColorStyle.white1),
              ),
            );
          }
          final item = detailViewModel.movie;
          return DetailItem(
            item: item!,
            releaseYear: detailViewModel.getYear(),
          );
        },
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({super.key, required this.item, this.releaseYear});

  final MovieDetail item;
  final String? releaseYear;

  bool checkSize(double height, double width) {
    return height < width;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final dWidth = deviceSize.width;
    final dHeight = deviceSize.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                child: CachedNetworkImage(
                  fit: checkSize(dHeight, dWidth) ? BoxFit.fitWidth : BoxFit.cover,
                  height:  dHeight / 4,
                  width: dWidth,
                  imageUrl: Constant.imgUrl + (item.backdropPath ?? ''),
                  errorWidget: (context, url, error) {
                    return Image.asset('assets/images/placeholder.jpg');
                  },
                  placeholder: (context, url) {
                    return Image.asset('assets/images/placeholder.jpg');
                  },
                  fadeInCurve: Curves.linear,
                ),
              ),
              Positioned(
                  top: checkSize(dHeight, dWidth)
                      ? dHeight / 4 - dHeight / 8 - dHeight / 48
                      : dHeight / 4 - dHeight / 12 + dHeight / 96,
                  left: 24,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 120,
                          width: 100,
                          imageUrl: Constant.imgUrl + (item.posterPath ?? ''),
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
                        width: 8,
                      ),
                      SizedBox(
                        width: dWidth - 140,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            item.title ?? '',
                            style: ModTextStyle.detailTitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                right: 8,
                top:  dHeight / 4 - (checkSize(dHeight, dWidth) ? dHeight/8 : dHeight / 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ModColorStyle.ratingContainer.withOpacity(0.52)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_border,
                        color: ModColorStyle.rating,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        item.voteAverage != null ? item.voteAverage!.toStringAsFixed(2) : 'N/A',
                        style: ModTextStyle.detailInfo
                            .copyWith(color: ModColorStyle.rating, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: checkSize(dHeight, dWidth) ? dWidth / 8 - dWidth/32 : dHeight / 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getIcon(Icons.calendar_today_outlined),
              Text(
                releaseYear ?? 'N/A',
                style: ModTextStyle.detailInfo,
              ),
              Text('  |  ', style: ModTextStyle.detailInfo),
              getIcon(CupertinoIcons.clock),
              Text(
                '${item.runtime} Minutes',
                style: ModTextStyle.detailInfo,
              ),
              Text('  |  ', style: ModTextStyle.detailInfo),
              getIcon(CupertinoIcons.ticket),
              Text(
                item.genres?.first.name ?? 'N/A',
                style: ModTextStyle.detailInfo,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              item.overview ?? 'N/A',
              style: ModTextStyle.itemDetail.copyWith(color: ModColorStyle.white2),
            ),
          )
        ],
      ),
    );
  }

  Widget getIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Icon(
        icon,
        size: 16,
        color: ModColorStyle.detailGrey,
      ),
    );
  }
}
