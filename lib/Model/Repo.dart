import 'dart:convert';

List<Repositries> listAllRepoRespFromJson(String str) => List<Repositries>.from(
    json.decode(str).map((x) => Repositries.fromJson(x)));

class Repositries {
  String repo_name;
  String created_date;

  /*final String last_pushed;
  final String description;
  final String branch;
  final String language;*/
  String url;

  /*final int stars;*/

  Repositries({
    this.repo_name,
    this.created_date,
    /* this.branch,
    this.description,
    this.language,
    this.last_pushed,
    this.stars,*/
    this.url,
  });

  factory Repositries.fromJson(Map<String, dynamic> json) => Repositries(
      repo_name: json["name"],
      url: json["html_url"],
      created_date: json["created_at"]);
}
