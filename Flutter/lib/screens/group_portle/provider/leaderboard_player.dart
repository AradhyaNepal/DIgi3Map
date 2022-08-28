class LeaderboardPlayers{
  bool isUser;
  String userName;
  int userId,userCoin;
  String? userImage;
  bool isAnonymous;
  LeaderboardPlayers({
    required this.userId,
    required this.userName,
    required this.userCoin,
    required this.isAnonymous,
    this.userImage,
    this.isUser=false
  });
  static String userIdJson="id",userNameJson="name",
      isAnonymousJson="isAnonymous",imageUrlJson="imageUrl",
      coinJson="coin";
  factory LeaderboardPlayers.fromMap(Map<String,dynamic> leaderBoardMap,bool isUser){
    return LeaderboardPlayers(
        userId: leaderBoardMap[userIdJson],
        userName: leaderBoardMap[userNameJson],
        userCoin: leaderBoardMap[coinJson],
        isAnonymous: leaderBoardMap[isAnonymousJson],
        userImage: leaderBoardMap[imageUrlJson],
        isUser: isUser
    );
  }
}