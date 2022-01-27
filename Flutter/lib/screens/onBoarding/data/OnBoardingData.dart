class OnBoardingModel{
  String heading;
  String value;
  OnBoardingModel({
    required this.heading,
    required this.value
  });
}
class OnBoardingData{
  ///List index 0 page 1, index 1 page 2 adn index 2 is page 3
  ///Inner value index 0 means heading, 1 means text
  ///I am lazy for not creating pojo class
  OnBoardingData();
  static List<OnBoardingModel> dataList=[
    OnBoardingModel(heading: "Work On Your Goals and Habits", value: "In this App you can set major 5 domain of your life you want to work on and the app will make sure you are working in all the domain without over prioritizing one and ignoring other"),
    OnBoardingModel(heading: "Compete and make new friends", value: "In This App you can take part in leaderboard where you can compete with 10 strangers every month and get price if you won. Also you can also follow some person and compete with them."),
    OnBoardingModel(heading: "Better Manage Your Time And Energy", value: "This App helps you to manage your time property and with energy filter the app will recommend task for you according to your energy level.")
  ];
}