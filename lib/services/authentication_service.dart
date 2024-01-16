import '../data_provider/api_constants.dart';
import '../data_provider/api_service.dart';

class AuthenticationService{

  ApiService apiService = ApiService();

  loginData({required var body})async{
    return await apiService.httpPost(url: ApiConstants.loginUrl, body: body);
  }

  registerData({required var body})async{
    return await apiService.httpPost(url: ApiConstants.registerUrl, body: body);
  }
  forgotPassword({required var body})async{
    return await apiService.httpPost(url: ApiConstants.forgetPasswordUrl, body: body);
  }


}