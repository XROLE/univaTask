import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:univa_task/app/core/failure/failure.dart';
import 'package:univa_task/utils/constants/error_text.dart';

class CustomHttpClient {
  final Dio dio;
  CustomHttpClient(this.dio);

  Future<Response?> get({
    required String url,
    required Map<String, String> headers,
  }) async {
    try {
      final Response response =
          await dio.get(url, options: Options(headers: headers));
      return response;
    } on DioException catch (e) {
      debugPrint("=================> $e");
      throw Failure(e.response?.data["message"]);
    } catch (e) {
      debugPrint("=================> $e");
      throw Failure(ErrorText.generic);
    }
  }

  Future<Response?> post({
    required String url,
    required Map<String, String> headers,
    Map<String, dynamic>? data,
    FormData? formData,
  }) async {
    try {
      Object? body = jsonEncode(data ?? {});
      Response? response = await dio.post(url,
          options: Options(headers: headers), data: formData ?? body);
      return response;
    } on DioException catch (e) {
      debugPrint("===============> $e");
      throw Failure(e.response?.data["message"]);
    } catch (e) {
      debugPrint("=================> $e");
      throw Failure(ErrorText.generic);
    }
  }
}
