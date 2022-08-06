import 'package:maraka/models/ImageStrapi.dart';

class Banner {
  var id;
  var url;
  var owner;
  var display;
  bool? splashscreen=false;
  var expire_date;
  bool? home=false;
  ImageStrapi? imageLarge;
  ImageStrapi? imageSmall;
  ImageStrapi? imageMedium;
  ImageStrapi? imageThumbnail;
  var imgUrl;
  Banner(
      {this.id,
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
