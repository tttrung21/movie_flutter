import 'package:simple_movie_app/model/movie_detail.dart';
import 'package:intl/intl.dart';
import '../../../api_service/api_service.dart';

class DetailViewModel{
  final ApiService apiService = ApiService();
  String? errorMessage;
  bool isLoading = false;
  MovieDetail? movie;
  Future<MovieDetail?> fetchMovie(int id) async {
    isLoading = true;
    try {
      movie = await apiService.fetchDetailMovie(id);
    } catch (e) {
      errorMessage = e.toString();
      rethrow;
    } finally {
      isLoading = false;
    }
    return movie;
  }
  String getYear() {
    // Parse the input date
    DateTime dateTime = DateTime.parse(movie?.releaseDate ?? '');
    // Format it to just the year
    return DateFormat('yyyy').format(dateTime);
  }
}