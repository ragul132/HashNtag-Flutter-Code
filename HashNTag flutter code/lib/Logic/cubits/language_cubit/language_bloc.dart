import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dating/language/localization/language_preference.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const SelectedLanguage(Locale('en')));

  /// Load saved language when app starts
  Future<void> loadSavedLanguage() async {
    String languageCode = await LanguagePreference.getLanguage();
    emit(SelectedLanguage(Locale(languageCode)));
  }

  Future<void> _changeLanguage(String code) async {
    await LanguagePreference.saveLanguage(code);
    emit(SelectedLanguage(Locale(code)));
  }

  Future<void> toEnglish() async => await _changeLanguage('en');

  Future<void> toArabic() async => await _changeLanguage('ar');

  Future<void> toSpanish() async => await _changeLanguage('es');

  Future<void> toHindi() async => await _changeLanguage('hi');

  Future<void> toGujarati() async => await _changeLanguage('gu');

  Future<void> toAfrikaans() async => await _changeLanguage('af');

  Future<void> toBengali() async => await _changeLanguage('be');

  Future<void> toIndonesian() async => await _changeLanguage('id');

  Future<void> tothai() async => await _changeLanguage('th');
}