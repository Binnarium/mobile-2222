import 'package:flutter/cupertino.dart';

abstract class ResourcesDto {
  final String? kind;

  ResourcesDto._({
    this.kind,
  });

  static ResourcesDto fromJson(Map<String, dynamic> payload) {
    final String? kind = payload['kind'];
    if (kind == null) {
      throw ErrorDescription("Online resource kind is empty");
    }
    if (kind.contains('LINK#'))
      return OnlineResourceDto._(
        kind: kind,
        name: payload['title'],
        description: payload['description'],
        redirect: payload['link'],
      );
    else
      throw ErrorDescription("Online resource kind not found");
  }
}

class OnlineResourceDto extends ResourcesDto {
  final String? name;
  final String? redirect;
  final String? description;
  OnlineResourceDto._({
    required String kind,
    this.name,
    this.redirect,
    this.description,
  }) : super._(kind: kind);
}
