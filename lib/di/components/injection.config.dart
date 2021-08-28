// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../../data/local/datasources/post/post_datasource.dart' as _i11;
import '../../data/network/apis/services.dart' as _i10;
import '../../data/network/dio_client.dart' as _i25;
import '../../data/network/rest_client.dart' as _i24;
import '../../data/repositry.dart' as _i9;
import '../../data/sharedpref/shared_preference_helper.dart' as _i8;
import '../../store/answers/answers_store.dart' as _i15;
import '../../store/answers/edit_answer/edit_answer_store.dart' as _i18;
import '../../store/create_question/create_question_store.dart' as _i16;
import '../../store/details_question/details_question_store.dart' as _i17;
import '../../store/error/error_store.dart' as _i4;
import '../../store/form/form_store.dart' as _i5;
import '../../store/home/home_store.dart' as _i19;
import '../../store/language/language_store.dart' as _i20;
import '../../store/login/login.dart' as _i21;
import '../../store/my_question/my_question_store.dart' as _i22;
import '../../store/profile/profile_store.dart' as _i23;
import '../../store/reset_password/reset_password.dart' as _i12;
import '../../store/sign_up/sign_up.dart' as _i13;
import '../../store/theme/theme_store.dart' as _i14;
import '../module/local_module.dart' as _i26;
import '../module/network_module.dart'
    as _i27; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.factoryAsync<_i3.Database>(() => localModule.provideDatabase(),
      preResolve: true);
  gh.factory<_i4.ErrorStore>(() => _i4.ErrorStore());
  gh.factory<_i5.FormStore>(() => _i5.FormStore());
  await gh.factoryAsync<_i6.SharedPreferences>(
      () => localModule.provideSharedPreferences(),
      preResolve: true);
  gh.factory<_i7.Dio>(
      () => networkModule.provideDio(get<_i8.SharedPreferenceHelper>()));
  gh.factory<_i9.Repository>(() => localModule.provideRepository(
      get<_i10.Services>(),
      get<_i8.SharedPreferenceHelper>(),
      get<_i11.PostDataSource>()));
  gh.factory<_i12.ResetPasswordStore>(
      () => _i12.ResetPasswordStore(get<_i9.Repository>()));
  gh.factory<_i13.SignUpStore>(() => _i13.SignUpStore(get<_i9.Repository>()));
  gh.factory<_i14.ThemeStore>(() => _i14.ThemeStore(get<_i9.Repository>()));
  gh.factory<_i15.AnswersStore>(() => _i15.AnswersStore(get<_i9.Repository>()));
  gh.factory<_i16.CreateQuestionStore>(
      () => _i16.CreateQuestionStore(get<_i9.Repository>()));
  gh.factory<_i17.DetailsQuestionStore>(
      () => _i17.DetailsQuestionStore(get<_i9.Repository>()));
  gh.factory<_i18.EditAnswersStore>(
      () => _i18.EditAnswersStore(get<_i9.Repository>()));
  gh.factory<_i19.HomeStore>(() => _i19.HomeStore(get<_i9.Repository>()));
  gh.factory<_i20.LanguageStore>(
      () => _i20.LanguageStore(get<_i9.Repository>()));
  gh.factory<_i21.LoginStore>(() => _i21.LoginStore(get<_i9.Repository>()));
  gh.factory<_i22.MyQuestionStore>(
      () => _i22.MyQuestionStore(get<_i9.Repository>()));
  gh.factory<_i23.ProfileStore>(() => _i23.ProfileStore(get<_i9.Repository>()));
  gh.singleton<_i11.PostDataSource>(_i11.PostDataSource());
  gh.singleton<_i24.RestClient>(_i24.RestClient());
  gh.singleton<_i8.SharedPreferenceHelper>(
      _i8.SharedPreferenceHelper(get<_i6.SharedPreferences>()));
  gh.singleton<_i25.DioClient>(_i25.DioClient(get<_i7.Dio>()));
  gh.singleton<_i10.Services>(
      _i10.Services(get<_i25.DioClient>(), get<_i24.RestClient>()));
  return get;
}

class _$LocalModule extends _i26.LocalModule {}

class _$NetworkModule extends _i27.NetworkModule {}
