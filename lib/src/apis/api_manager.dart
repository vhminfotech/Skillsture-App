import 'package:dio/dio.dart';
import '../ui/auth/login/login_response.dart';
import 'api_service.dart';
import 'error_model.dart';

 class ApiManager {
  final ApiService _apiService = ApiService();

  Future<ResLoginModel> login(String _userName,String _password) async {
    try {
      final response = await _apiService.post(
        'login',
        data: {'username': _userName, 'password': _password},
      );
      return ResLoginModel.fromJson(response.data);
    } on DioError catch (error) {
      throw ErrorModel.fromJson(error.response.data);
    }
  }
}
