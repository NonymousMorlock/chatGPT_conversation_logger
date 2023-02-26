import 'package:conversation_log/core/common/settings/domain/settings.dart';

abstract class ISettingRepository {
  Future<Settings> getSetting();

  Future<bool> getDarkModeSetting();
  Future<void> setDarkModeSetting({required bool value});
}
