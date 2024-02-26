import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:snipit/features/account/data/datasource/account_datasource.dart';
import 'package:snipit/features/account/data/repositories/account_repository_impl.dart';
import 'package:snipit/features/account/domain/repositories/account_repository.dart';
import 'package:snipit/features/account/domain/usecases/check_user_name_usecase.dart';
import 'package:snipit/features/account/presentation/bloc/update_user_name_bloc.dart';
import 'package:snipit/features/discover/data/datasource/discovery_data_source.dart';
import 'package:snipit/features/discover/data/repository/discovery_repository_impl.dart';
import 'package:snipit/features/discover/domain/repository/discovery_repository.dart';
import 'package:snipit/features/discover/domain/usecases/get_discover_news.dart';
import 'package:snipit/features/discover/domain/usecases/get_discover_themes_usecase.dart';
import 'package:snipit/features/discover/domain/usecases/update_discover_themes_usecase.dart';
import 'package:snipit/features/discover/presentation/bloc/discover/discovery_bloc.dart';
import 'package:snipit/features/discover/presentation/bloc/discoverFeed/discover_feed_bloc.dart';
import 'package:snipit/features/feed/data/datasource/feed_data_source.dart';
import 'package:snipit/features/feed/domain/repositories/feed-repository.dart';
import 'package:snipit/features/feed/domain/usecases/add_interaction_usecase.dart';
import 'package:snipit/features/feed/domain/usecases/get_my_news_usecase.dart';
import 'package:snipit/features/feed/domain/usecases/get_news_by_category_usecase.dart';
import 'package:snipit/features/feed/domain/usecases/get_preference_usecase.dart';
import 'package:snipit/features/feed/domain/usecases/like_newsby_id_usecase.dart';
import 'package:snipit/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:snipit/features/feed/presentation/bloc/feed_detail_bloc/feed_details_bloc.dart';
import 'package:snipit/features/onboarding/data/datasource/onboarding_data_source.dart';
import 'package:snipit/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:snipit/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:snipit/features/onboarding/domain/usecases/check_email_use_case.dart';
import 'package:snipit/features/onboarding/domain/usecases/check_otp_use_case.dart';
import 'package:snipit/features/onboarding/domain/usecases/create_password_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/get_category_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/get_subcategory_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/login_via_email_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/register_via_email_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/social_auth_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/update_user_details_usecase.dart';
import 'package:snipit/features/onboarding/domain/usecases/verify_otp_usecase.dart';
import 'package:snipit/features/onboarding/presentation/bloc/category/category_bloc.dart';
import 'package:snipit/features/onboarding/presentation/bloc/login/login_bloc.dart';
import 'package:snipit/features/onboarding/presentation/bloc/signup/signup_bloc.dart';
import 'package:snipit/features/onboarding/presentation/bloc/subcategory/subcategory_bloc.dart';
import 'package:snipit/features/onboarding/presentation/bloc/update_user_details/update_user_details_bloc.dart';
import 'package:snipit/features/search_news/data/datasource/search_news_datasource.dart';
import 'package:snipit/features/search_news/data/repositories/search_news_repositoryimpl.dart';
import 'package:snipit/features/search_news/domain/repositories/search_news_reporsitory.dart';
import 'package:snipit/features/search_news/domain/usecases/search_news_usecase.dart';
import 'package:snipit/features/search_news/presentation/bloc/search_news_bloc.dart';
import '../core/network/network_info.dart';
import '../features/feed/data/datasource/repositories/feed_repository_impl.dart';
import '../features/account/presentation/bloc/update_user_profile_bloc.dart';
import '../features/onboarding/presentation/bloc/forgot_password_bloc/forgot_password_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  general();
  onboarding();
  injectFeed();
  injectDiscover();
}

void general() {
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

void onboarding() {
  sl.registerLazySingleton<OnBoardingDataSource>(
      () => OnboardingDataSourceImpl());
  sl.registerLazySingleton<AccountDataSource>(() => AccountDataSourceImpl());
  sl.registerLazySingleton<SearchNewsDataSource>(() => SearchNewsDataSourceImpl());
  sl.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<SearchNewsRepository>(
      () => SearchNewsRepositoryImpl(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => GetCategoryUseCase(categoryRepository: sl()));
  sl.registerFactory<CategoryBloc>(
      () => CategoryBloc(getCategoryUseCase: sl()));
  sl.registerFactory<SearchNewsBloc>(
          () => SearchNewsBloc(searchNewsUseCase: sl()));
  sl.registerLazySingleton(() => GetSubcategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => RegisterViaEmailUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchNewsUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckOtpUseCase(onboardingRepository: sl()));
  sl.registerLazySingleton(
      () => CreatePasswordUseCase(onboardingRepository: sl()));
  sl.registerLazySingleton(() => SocialAuthUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckUserNameUseCase(repository: sl()));
  sl.registerFactory<SubcategoryBloc>(
      () => SubcategoryBloc(getSubcategoryUseCase: sl()));

  sl.registerFactory<UpdateUserNameBloc>(() => UpdateUserNameBloc(
      checkUserNameUseCase: sl(), updateUserDetailsUseCase: sl()));

  sl.registerFactory<SignupBloc>(() => SignupBloc(
      registerViaEmailUseCase: sl(),
      verifyOtpUseCase: sl(),
      socialAuthUseCase: sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(loginViaEmailUsecase: sl()));
  sl.registerLazySingleton(() => LoginViaEmailUsecase(repository: sl()));
  sl.registerLazySingleton<UpdateUserDetailsBloc>(
      () => UpdateUserDetailsBloc(updateUserDetailsUseCase: sl()));
  sl.registerFactory<UpdateUserProfileBloc>(
      () => UpdateUserProfileBloc(updateUserDetailsUseCase: sl()));

  sl.registerFactory<ForgotPasswordBloc>(() => ForgotPasswordBloc(
      checkEmailUseCase: sl(),
      checkOtpUseCase: sl(),
      createPasswordUseCase: sl()));
  sl.registerLazySingleton(() => CheckEmailUseCase(onboardingRepository: sl()));
}

void injectFeed() {
  sl.registerLazySingleton<FeedDataSource>(() => FeedDataSourceImpl());
  sl.registerLazySingleton<FeedRepository>(
      () => FeedRepositoryImpl(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<AccountRepository>(
      () => AccountRepositoryImpl(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => GetPreferenceUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetNewsByCategoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMyNewsUseCase(repository: sl()));
  sl.registerLazySingleton(() => LikeNewsByIdUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddInteractionUseCase(repository: sl()));
  sl.registerFactory<FeedBloc>(() => FeedBloc(
      likeNewsUseCase: sl(),
      getPreferenceUsecase: sl(),
      getNewsByCategoryUseCase: sl(),
      getMyNewsUsecase: sl()));

  sl.registerFactory<FeedDetailBloc>(
      () => FeedDetailBloc(addInteractionUseCase: sl()));
}

void injectDiscover() {
  sl.registerLazySingleton<DiscoveryDataSource>(
      () => DiscoveryDataSourceImpl());
  sl.registerLazySingleton<DiscoveryRepository>(
      () => DiscoveryRepositoryimpl(dataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton(() => GetDiscoverThemesUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateDiscoverThemesUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetDiscoverNewsUseCase(repository: sl()));
  sl.registerFactory<DiscoveryBloc>(() => DiscoveryBloc(
      getDiscoverThemesUseCase: sl(), updateDiscoverThemesUsecase: sl()));
  sl.registerFactory<DiscoverFeedBloc>(() => DiscoverFeedBloc(
        getDiscoverNewsUseCase: sl(),
      ));
}
