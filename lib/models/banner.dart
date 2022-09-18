import 'package:maraka/models/ImageStrapi.dart';

class Banner {
  var id;
  var url;
  var owner;
  var display;
  var how_Long;
  bool? splashscreen = false;
  var expire_date;
  bool? home = false;
  ImageStrapi? imageLarge;
  ImageStrapi? imageSmall;
  ImageStrapi? imageMedium;
  ImageStrapi? imageThumbnail;
  var imgUrl;
  Banner(
      {this.id,
      this.how_Long,
      this.url,
      this.imgUrl,
      this.owner,
      this.display,
      this.splashscreen,
      this.expire_date,
      this.home,
      this.imageThumbnail,
      this.imageSmall,
      this.imageMedium,
      this.imageLarge,
      Homed});
}
