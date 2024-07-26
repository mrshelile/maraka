// final Map<dynamic, dynamic> categories = {
//   "all": "All",
//   "cars": "Cars",
//   "others": "Others"
//   // "phoneandcomputers": "Phone & Computers",
//   // "homeandappliances": "Home & Appliances",
//   // "tvandaudio": "Tv & Audio",
//   // "fashionandwearable": "Fashion & wearable",
//   // "stationaryandoffice": "Stationary & Office",
//   // "farming": "Farming",
//   // "beauty": "Beauty",
//   // "rental": "Rental",
//   // "jobs": "Jobs"
// };
List<Map<String, dynamic>> categories = [
  // {"icon": "assets/mindeset.svg", "text": "All"},
  {"icon": "assets/mindeset.svg", "text": "Cars"},
  {"icon": "assets/mindeset.svg", "text": "Miscellaneous"},
];
int pageSize = 50;
// var server = "https://maraka.co.ls/buyandsellDjango-apis";
// var server = "http://10.4.5.220:8000/buyandsellDjango-apis";
var server = "https://ntateshelile.pythonanywhere.com/buyandsellDjango-apis";
// var ws_server = "http://192.168.0.100:3000";
const kAnimationDuration = Duration(milliseconds: 200);

const defaultDuration = Duration(milliseconds: 250);

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
