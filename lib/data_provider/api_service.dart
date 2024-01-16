import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class ApiService{

  httpPost({required String url,required var body})async{
    url = ApiConstants.BASEURL + url;
    Map<String,String> tokenHeader={

    };
    var response = await http.post(Uri.parse(url),headers: tokenHeader, body: body);
    print("post:: ${url}");
    if (response.statusCode == 401)
    {
      return response;
    }
    else{
      return response;
    }
  }

  httpGet({required String url,required BuildContext context, required bool isToken})async{
    url = ApiConstants.BASEURL + url;
    Map<String,String> tokenHeader={

    };
    Map<String,String> header={
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    print("get:: ${url}");
    var response = await http.get(Uri.parse(url),headers:  isToken ?tokenHeader:header);

    if (response.statusCode == 401)
    {
      return response;
    }else if(response.statusCode == 403) {
    }
    else{
      return response;
    }
  }
}