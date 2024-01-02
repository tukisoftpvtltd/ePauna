// !This contains the base Url
import '../user_data/data.dart';

var baseUrl = "https://pauna.tukisoft.com.np/";

// !Api url for the newlyAdded
newlyadded() => 'api/selectNewelyAddedServiceProviders';

// !Api url for the topDestination
topdestination() => 'api/selectMostPopularServiceProviders';

// // !Login Api
// loginApi({required String email, required String password}) =>
//     '${baseUrl}api/userlogin?LoginEmail=$email&LoginPassword=$password';

// // !SignUp Api
// signupApi(
//         {required String firstname,
//         required String lastname,
//         required String email,
//         required String password,
//         required String phone}) =>
//     "${baseUrl}api/user?FirstName=$firstname&LastName=$lastname&Email=$email&MobileNumber=$phone&Password=$password";

// !getDesc
getDesc({required String resurant_ID}) =>
    'https://pauna.tukisoft.com.np/api/getPublicServiceProviderDetails/$resurant_ID';

var apiType = 'GET';

// !descImage Api
getImgApi({required String resurant_ID}) =>
    'api/serviceProviderImageGallery/$resurant_ID';

// !searchResult
// searchResultApi({required String location}) =>
//     'api/filterServiceProviders/$location/1,2,3,4/0/0/0/recommended';

//!saved
savedApi() => 'api/SaveServiceProvider/$user_id';

//!selectRoomsApi
selectRoomApi({required String restID}) =>
    'api/selectServiceWithServiceRates/$restID';

// userApi() => 'api/user/i9bE4UomIqpHTddpDUOj202212115289';
