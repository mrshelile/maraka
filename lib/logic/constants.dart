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
  {"icon": "assets/mindeset.svg", "text": "All"},
  {"icon": "assets/mindeset.svg", "text": "Cars"},
  {"icon": "assets/mindeset.svg", "text": "Others"},
];

var server = "https://maraka.co.ls/buyandsellDjango-api";
//var server = "http://127.0.0.1:3002/buyandsellDjango-api";
// var server = "https://agile-headland-32385.herokuapp.com";

const kAnimationDuration = Duration(milliseconds: 200);

const defaultDuration = Duration(milliseconds: 250);

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
