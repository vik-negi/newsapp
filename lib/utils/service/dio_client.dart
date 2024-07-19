import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as dev;
import 'package:news/configs/app_config.dart';
import 'package:news/utils/service/failure.dart';
import 'package:news/utils/widgets/show_snackbar.dart';

class DioClient {
  DioClient() {
    addInterceptors();
  }
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      headers: {
        "Accept": "application/json, text/plain, */*",
      },
      contentType: '*/*',
    ),
  );

  addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (exception, handler) {
          // log.e("Message ${exception.message}");
          handler.next(exception);
        },
        onRequest: (request, handler) {
          log("Request: ${request.uri}");
          if (request.queryParameters.isNotEmpty) {
            log("Params: ${request.queryParameters}");
          }
          if (request.extra.isNotEmpty) {
            log("Extras: ${request.extra}");
          }

          handler.next(request);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
      ),
    );
  }

  Future<Either<Error, T>> patchRequest<Error, T>(
    String endPoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    bool isFormData = false,
    Function? fromJson,
  }) async {
    Response response;

    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*, multipart/form-data",
    };

    try {
      log(endPoint + " -- " + body.toString() + " , " + query.toString());
      FormData data = FormData.fromMap(body ?? {});

      response = await _dio.patch(endPoint,
          data: isFormData ? data : body, queryParameters: query ?? {});
    } on DioException catch (e) {
      log("Catch Error:  $endPoint ${e.message}");

      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        // logOut();
      }

      log(e.toString());

      return Left(APIFailure(e.message ?? "API Exception") as Error);
    }

    log(response.data);

    if (fromJson != null) {
      return Right(fromJson(response.data) as T);
    }
    return Right((response.data) as T);
  }

  Future<Either<Error, T>> getRequest<Error, T>(String endPoint,
      {Map<String, dynamic>? queryParameters,
      int? handleForStatusCode,
      Function? fromJson}) async {
    Response response;

    _dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "*/*, multipart/form-data",
    };

    try {
      response = await _dio.get(endPoint, queryParameters: queryParameters);
    } on DioException catch (e) {
      log("Error catch: $endPoint ${e.message}");
      if (handleForStatusCode != null &&
          e.response?.statusCode == handleForStatusCode) {
        return Left(APIFailure(e.message ?? "API Exception") as Error);
      }
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        // logOut();
      }

      return Left(APIFailure(e.message ?? "API Exception") as Error);
    }
    if (response.data == null) {
      return Left(APIFailure("API Exception") as Error);
    }
    if (fromJson != null) {
      return Right(fromJson(response.data) as T);
    }
    return Right((response.data) as T);
  }

  Future<Either<Error, T>> postRequest<Error, T>(
    String endPoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? body2,
    Map<String, dynamic>? query,
    FormData? form,
    List<MultipartFile>? files,
    bool isMultiPartFile = false,
    bool isAuth = false,
    Function? fromJson,
  }) async {
    Response response;

    if (isMultiPartFile) {
      _dio.options.headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
      };
    } else {
      _dio.options.headers = {
        "Content-Type": "application/json",
        "Accept": "*/*",
      };
    }

    try {
      FormData? formData;
      if (body != null) {
        formData = FormData.fromMap(body);
        if (files != null && files.isNotEmpty) {
          for (int i = 0; i < files.length; i++) {
            formData.files.add(MapEntry('post_image', files[i]));
          }
        }
      }

      if (form != null) {
        formData = form;
      }

      log("endPoint: $endPoint ${formData?.fields} ${formData?.files}");

      response = await _dio.post(
        endPoint,
        data: formData ?? body2,
        queryParameters: query,
      );

      dev.log("Response: ${response.data} & ${response.statusCode}");

      if (fromJson != null) {
        if (response.data.runtimeType == String) {
          return Right(fromJson(jsonDecode(response.data as String)) as T);
        }
        return Right((fromJson(response.data)) as T);
      }
      return Right((response.data) as T);
    } on DioException catch (e) {
      log("dio Error catch: ${e.response?.data} ${e.response?.statusCode} $e");
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        // logOut();
      }
      if (e.response?.statusCode == 400) {
        // showSnackbar(getx.Get.context!,
        //     e.response?.data["message"] ?? "Something went wrong");
      }
      if (endPoint.contains("login")) {
        return Left(APIFailure(e.response?.data["invalid"] ?? "API Exception")
            as Error);
      }
      return Left(
          APIFailure(e.response?.data["error"] ?? "API Exception") as Error);
    } catch (e) {
      log("Catch Error:  $endPoint $e");
      return Left(APIFailure(e.toString()) as Error);
    }
  }

  Future<Either<Error, T>> deleteRequest<Error, T>(String endPoint,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? query,
      Function? fromJson}) async {
    Response response;

    try {
      response = await _dio.delete(endPoint,
          data: body == null ? null : FormData.fromMap(body),
          queryParameters: query);
      // log.v(response.data);
      if (response.data == null || response.data == "") {
        return Right("Done" as T);
      }
      if (fromJson != null) {
        return Right(fromJson(response.data) as T);
      }
      return Right((response.data) as T);
    } on DioException catch (e) {
      log("Catch Error:  $endPoint $e");
      return Left(APIFailure(e.message ?? "API Exception") as Error);
    }
  }

  Future<Either<Error, T>> putRequest<Error, T>(
    String endPoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    bool isMultiPartFile = false,
    List<MultipartFile>? files,
    bool isFormData = true,
    FormData? form,
    Function? fromJson,
  }) async {
    Response response;

    if (isMultiPartFile) {
      _dio.options.headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
      };
    } else {
      _dio.options.headers = {
        "Content-Type": "application/json",
        "Accept": "*/*",
      };
    }

    try {
      FormData? formData;
      if (body != null) {
        formData = FormData.fromMap(body);
        if (files != null && files.isNotEmpty) {
          for (int i = 0; i < files.length; i++) {
            formData.files.add(MapEntry('post_image', files[i]));
          }
        }
      }

      if (form != null) {
        formData = form;
      }

      log("form data : ${formData?.fields} ${formData?.files}");

      if (query == null && body == null) {
        if (isFormData) {
          response = await _dio.put(
            endPoint,
            data: formData,
          );
        } else {
          response = await _dio.put(
            endPoint,
          );
        }
      } else if (query == null) {
        response = await _dio.put(
          endPoint,
          data: !isFormData ? body : formData,
        );
      } else {
        response = await _dio.put(
          endPoint,
          data: formData,
          queryParameters: query,
        );
      }

      log("Response: ${response.data} & ${response.statusCode}");
    } on DioException catch (e) {
      log("Error catch: ${e.message}");
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        // logOut();
      }

      log("Error catch: ${e.response?.data}");

      return Left(APIFailure(
        e.message ?? "API Exception",
        faliureData: e.response?.data,
      ) as Error);

      // throw Exception(e.message);
    }

    if (fromJson != null) {
      return Right(fromJson(response.data) as T);
    }
    return Right((response.data) as T);
  }
}
