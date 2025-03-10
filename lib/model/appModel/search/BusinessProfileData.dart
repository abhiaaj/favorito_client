import 'package:favorito_user/model/appModel/Business/AttributesModel.dart';
import 'package:favorito_user/model/appModel/Business/Category.dart';
import 'package:favorito_user/model/appModel/Business/RelationModel.dart';
import 'package:favorito_user/model/appModel/HighlightsModel.dart';

class BusinessProfileData {
  var id;
  String businessId;
  String firebaseId;
  String shortDesciption;
  String priceRange;
  String postalCode;
  String location;
  String phone;
  String isPro;
  String proKey;
  String landline;
  String businessEmail;
  var totalReviews;
  String startHours;
  String endHours;
  var distance;
  var businessCategoryId;
  String businessName;
  String townCity;
  String state;
  String photo;
  String businessStatus;
  var avgRating;
  String address1;
  String address2;
  String address3;
  String website;
  String shortDescription;
  String paymentMethod;
  List<Attributes> attributes;
  List<Relation> relation;
  List<Category> subCategory;
  List<HighlightPhoto> highlightPhoto;
  BusinessProfileData({
    this.id,
    this.businessId,
    this.firebaseId,
    this.shortDesciption,
    this.priceRange,
    this.postalCode,
    this.location,
    this.phone,
    this.isPro,
    this.proKey,
    this.landline,
    this.businessEmail,
    this.totalReviews,
    this.startHours,
    this.endHours,
    this.distance,
    this.businessCategoryId,
    this.businessName,
    this.townCity,
    this.state,
    this.photo,
    this.businessStatus,
    this.website,
    this.address1,
    this.address2,
    this.address3,
    this.avgRating,
    this.shortDescription,
    this.paymentMethod,
    this.attributes,
    this.relation,
    this.subCategory,
    this.highlightPhoto,
  });

  BusinessProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    firebaseId = json['firebase_chat_id'];
    shortDesciption = json['short_desciption'];
    priceRange = json['price_range'];
    postalCode = json['postal_code'];
    location = json['location'];
    phone = json['phone'];
    isPro = json['is_pro'].toString();
    proKey = json['pro_key'];
    landline = json['landline'];
    businessEmail = json['business_email'];
    totalReviews = json['total_reviews'];
    startHours = json['start_hours'];
    endHours = json['end_hours'];
    distance = json['distance'];
    businessCategoryId = json['business_category_id'];
    businessName = json['business_name'];
    townCity = json['town_city'];
    state = json['state'];
    photo = json['photo'] ??
        'https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-profile-placeholder-image-png.png';
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    businessStatus = json['business_status'];
    website = json['website'];
    shortDescription = json['shortDescription;'];
    paymentMethod = json['payment_method'];
    avgRating = json['avg_rating'];
    if (json['attributes'] != null) {
      attributes = [];
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
    if (json['relation'] != null) {
      relation = [];
      json['relation'].forEach((v) {
        relation.add(new Relation.fromJson(v));
      });
    }
    if (json['sub_category'] != null) {
      subCategory = [];
      json['sub_category'].forEach((v) {
        subCategory.add(new Category.fromJson(v));
      });
    }
    if (json['highlight_photo'] != null) {
      highlightPhoto = [];
      json['highlight_photo'].forEach((v) {
        highlightPhoto.add(new HighlightPhoto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['firebase_chat_id'] = this.firebaseId;
    data['short_desciption'] = this.shortDesciption;
    data['price_range'] = this.priceRange;
    data['postal_code'] = this.postalCode;
    data['location'] = this.location;
    data['phone'] = this.phone;
    data['is_pro'] = this.isPro;
    data['pro_key'] = this.proKey;
    data['landline'] = this.landline;
    data['business_email'] = this.businessEmail;
    data['total_reviews'] = this.totalReviews;
    data['start_hours'] = this.startHours;
    data['end_hours'] = this.endHours;
    data['distance'] = this.distance;
    data['business_category_id'] = this.businessCategoryId;
    data['business_name'] = this.businessName;
    data['town_city'] = this.townCity;
    data['state'] = this.state;
    data['photo'] = this.photo;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['business_status'] = this.businessStatus;
    data['shortDescription'] = this.shortDescription;
    data['payment_method'] = this.paymentMethod;
    data['avg_rating'] = this.avgRating;
    data['website'] = this.website;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    if (this.relation != null) {
      data['relation'] = this.relation.map((v) => v.toJson()).toList();
    }
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory.map((v) => v.toJson()).toList();
    }
    if (this.highlightPhoto != null) {
      data['highlight_photo'] =
          this.highlightPhoto.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HighlightPhoto {
  String photo;

  HighlightPhoto({this.photo});

  HighlightPhoto.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    return data;
  }
}
