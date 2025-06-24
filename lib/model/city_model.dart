class CityModel {
  int sno;
  String cityName;
  String cityNameAr;

  CityModel({required this.sno, required this.cityName, required this.cityNameAr});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      sno: json['sno'],
      cityName: json['city_name'],
      cityNameAr: json['city_name_ar'],
    );
  }
}