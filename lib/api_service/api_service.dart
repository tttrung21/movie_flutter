import 'dart:convert';

import 'package:simple_movie_app/model/list_movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:simple_movie_app/model/movie_detail.dart';
import 'package:simple_movie_app/shared/constant.dart';

class ApiService {

  Future<List<Results>> fetchMovies({int page = 1}) async{
    final url = '${Constant.listMovieUrl}&api_key=${Constant.apiKey}&page=$page}';
    final res = await http.get(Uri.parse(url));
    print(page);
    return ListMovie.fromJson(jsonDecode(res.body)).results ?? [];
  }

  Future<MovieDetail> fetchDetailMovie(int id) async{
    final url = "${Constant.detailMovieUrl}$id?api_key=${Constant.apiKey}";
    final res = await http.get(Uri.parse(url));
    return MovieDetail.fromJson(jsonDecode(res.body));
  }
}
