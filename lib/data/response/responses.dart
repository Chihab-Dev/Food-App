import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: 'fullName')
  String? fullName;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'uid')
  String? uid;

  CustomerResponse(this.fullName, this.phoneNumber, this.uid);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) => _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}
