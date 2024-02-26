// ignore_for_file: constant_identifier_names

const String baseUrl = "https://snipit-backend-git-qa-aashays-projects.vercel.app/api";

// const String baseUrl = "https://snipit-backend-k2jopitgt-aashays-projects.vercel.app/api";

// const String baseUrl =
//     "https://snipit-backend-git-qa-aashays-projects.vercel.app/api";



//===================== Onboarding Api's ===========================

const String categoryUrl = baseUrl + "/category/get-categories";
const String subcategoryUrl = baseUrl + "/subCategory/subcategories";
const String registerViaEmailUrl = baseUrl + "/auth/register";
const String verifyOtpUrl = baseUrl + '/auth/verify-otp';
const String userLoginUrl = baseUrl + "/auth/login";
const String putUserDetailsUrl = baseUrl + "/user/update";

//===================== User Feed Api's ===========================
const String getMyPreferencesUrl = baseUrl + "/user/getMyPreferences";
const String getNewsByCategoryUrl = baseUrl + "/news/getNewsbyCategory";
const String likeNewsIdUrl = baseUrl + "/likeNews/like";
const String getNewsByUserUrl = baseUrl + "/news/getNewsbyUser";
const String socialAuthUrl = baseUrl + "/auth/social-auth";
const String updateCategoryUrl = baseUrl + "/user/updateMyPreferences";
const String getmydiscoverythemesUrl = baseUrl + "/user/getMyDiscoverThemes";
const String getAllDiscoverThemesUrl = baseUrl + "/user/getDiscoverThemes";
const String updateDiscoverThemesUrl = baseUrl + "/user/updateMyDiscoverThemes";
const String getDiscoverNewsUrl = baseUrl + "/news/getDiscoveryNewsByUser";
const String updateUserNameUrl = baseUrl + "/user/check-username";
const String interactionUrl = baseUrl + "/interaction";
const String resetPasswordViaEmail = baseUrl + "/user/resetPasswordViaEmail";
const String verifyUserOtpUrl = baseUrl + "/user/verifyOTP";
const String updatePassword = baseUrl + "/user/updatePassword";
const String searchNewsUrl = baseUrl + "/user/getUserNews";
