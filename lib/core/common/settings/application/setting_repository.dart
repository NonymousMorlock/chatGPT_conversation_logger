import 'package:conversation_log/core/common/settings/domain/i_setting_repository.dart';
import 'package:conversation_log/core/common/settings/domain/settings.dart';
import 'package:conversation_log/core/services/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository implements ISettingRepository {
  final _db = sl<SharedPreferences>();

  @override
  Future<Settings> getSetting() async {
    return _getSettingData();
  }

  @override
  Future<bool> getDarkModeSetting() async {
    final settingData = await _getSettingData();
    return settingData.isDarkMode;
  }

  @override
  Future<void> setDarkModeSetting({required bool value}) async {
    final settingData = await _getSettingData();
    final newSettingData = settingData.copyWith(isDarkMode: value);
    await _db.setString(Settings.setting, newSettingData.toJson());
  }

  Future<Settings> _getSettingData() async {
    final data = _db.getString(Settings.setting);
    if (data == null) {
      return const Settings(isDarkMode: false);
    } else {
      return Settings.fromJson(data);
    }
  }
}
