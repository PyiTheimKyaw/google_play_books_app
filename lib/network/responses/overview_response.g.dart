// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverviewResponse _$OverviewResponseFromJson(Map<String, dynamic> json) =>
    OverviewResponse(
      json['results'] == null
          ? null
          : OverviewVo.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OverviewResponseToJson(OverviewResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
