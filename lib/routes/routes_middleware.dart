import 'package:danastoreadminpanel/data/repositories/authentication/authentication_repository.dart';
import 'package:danastoreadminpanel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RRrouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
   return AuthenticationRepository.instance.IsAuthenticated ? null : const RouteSettings(name: RRoutes.login);
  }
}