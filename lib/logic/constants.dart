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
    
var server = "http://192.168.43.89:3012";
// var server = "https://agile-headland-32385.herokuapp.com";
const kAnimationDuration = Duration(milliseconds: 200);

const defaultDuration = Duration(milliseconds: 250);
class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
