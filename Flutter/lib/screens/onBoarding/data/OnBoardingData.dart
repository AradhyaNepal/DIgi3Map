class OnBoardingModel{
  String heading;
  String value;
  OnBoardingModel({
    required this.heading,
    required this.value
  });
}
class OnBoardingData{
  OnBoardingData();
  static List<OnBoardingModel> dataList=[
    OnBoardingModel(heading: "Work On Your Goals and Habits", value: "In this App you can set major 5 domain of your life you want to work on."),
    OnBoardingModel(heading: "Compete and make new friends", value: "In This App you can take part in leaderboard where you can compete with 10 new strangers every month."),
    OnBoardingModel(heading: "Better Manage Your Time And Energy", value: "This App helps you to manage your time property and have energy filter to filter your Routine. ")
  ];
}