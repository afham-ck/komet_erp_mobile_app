import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String username,
    required String email,
    required String role,
    @JsonKey(name: 'store_id') int? storeId,
    @JsonKey(name: 'store_name') String? storeName,
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    username: user.username,
    email: user.email,
    role: user.role,
    storeId: user.storeId,
    storeName: user.storeName,
    accessToken: user.accessToken,
    refreshToken: user.refreshToken,
  );

  User toEntity() => User(
    id: id,
    username: username,
    email: email,
    role: role,
    storeId: storeId,
    storeName: storeName,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
