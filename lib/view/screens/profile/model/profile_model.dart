
class ProfileModel {
  int id;
  String dateCreated;
  String email;
  String firstName;
  String lastName;
  String role;
  String username;
  ProfileAddressModel billing;
  ProfileAddressModel shipping;
  bool isPayingCustomer;
  String avatarUrl;
  List<MetaData> metaData;

  ProfileModel(
      {this.id,
        this.dateCreated,
        this.email,
        this.firstName,
        this.lastName,
        this.role,
        this.username,
        this.billing,
        this.shipping,
        this.isPayingCustomer,
        this.avatarUrl,
        this.metaData});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    role = json['role'];
    username = json['username'];

    billing = json['billing'] != null ? new ProfileAddressModel.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null ? new ProfileAddressModel.fromJson(json['shipping']) : null;

    isPayingCustomer = json['is_paying_customer'];
    avatarUrl = json['avatar_url'];
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData.add(new MetaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['billing'] = this.billing.toJson();
    data['shipping'] = this.shipping.toJson();
    data['meta_data'] = this.metaData.map((v) => v.toJson()).toList();
    return data;
  }
}

class MetaData {
  int id;
  String key;
  String value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    if(json['value'].runtimeType == String) {
      value = json['value'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class ProfileAddressModel {
  int id;
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String email;
  String phone;
  String stateIso;

  ProfileAddressModel(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.postcode,
        this.country,
        this.state,
        this.email,
        this.phone,
        this.id,
        this.stateIso
      });

  ProfileAddressModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    postcode = json['postcode'];
    if(json['country'] != null) {
      country = json['country'];
    }
    if(json['state'] != null) {
      state = json['state'];
    }
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    stateIso = json['state_iso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['company'] = this.company;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['state'] = this.state;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['id'] = this.id;
    return data;
  }
}