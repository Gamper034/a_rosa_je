class Application {
  final String id;
  final String userId;
  final String userFirstName;
  final String userLastName;
  final String userAvatar;
  final int nbGuardsDonebyUser;

  Application({
    required this.id,
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    required this.userAvatar,
    required this.nbGuardsDonebyUser,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      userId: json['user']['id'],
      userFirstName: json['user']['firstName'],
      userLastName: json['user']['lastName'],
      userAvatar: json['user']['avatar'],
      nbGuardsDonebyUser: json['user']['nbGuardsDone'],
    );
  }
}
