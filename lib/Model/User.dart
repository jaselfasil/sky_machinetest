import 'dart:convert';

User userRespFromJson(String str) => User.fromJson(json.decode(str));
class User {
   String username;
   String avatar;
   String htmlUrl;
  /* String followersUrl;
   String followingUrl;
   String starredUrl;
   String subscriptionUrl;
   String organizationsUrl;
   String reposUrl;
   String eventsUrl;*/
   String name;
  /* String company;
   String bio;
   String blog;*/
   int publicRepos;
  /* String message;*/
   int id;
   int followers;
   int following;
   String joinDate;

  User({
    this.id,
    this.username,
    this.avatar,
    this.htmlUrl,
   /* this.followersUrl,
    this.bio,
    this.followingUrl,
    this.starredUrl,
    this.subscriptionUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,*/
    this.name,
   /* this.company,
    this.blog,*/
    this.publicRepos,
   /* this.message,*/
    this.followers,
    this.following,
    this.joinDate
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['id'] ?? 0,
      username: json['login'] ?? 'Error loading data',
      avatar: json['avatar_url'] ?? 'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png',
      htmlUrl: json['html_url'],
    /*  followersUrl: json['followers_url'],
      followingUrl: json['following_url'],
      starredUrl: json['starred_url'],
      subscriptionUrl: json['subscriptions_url'],
      organizationsUrl: json['organizations_url'],
      reposUrl: json['repos_url'],
      eventsUrl: json['events_url'],*/
      name: json['name'] ?? '...',
     /* company: json['company'] ?? '...',
      blog: json['blog'] ?? '..',
      bio: json['bio'] ?? '...',*/
      publicRepos: json['public_repos'] ?? 0,
     /* message: json['message'] ?? 'Error!',*/
      followers: json["followers"] ?? 0,
      following: json["following"] ?? 0,
      joinDate: json["created_at"]
    );
  }

