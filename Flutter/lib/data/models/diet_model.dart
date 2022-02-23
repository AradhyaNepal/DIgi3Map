import 'package:digi3map/data/services/assets_location.dart';

class Diet{
  String id,image,name,protein,fat,carbs,description;
  bool showDescription;
  Diet({
    required this.id,
    required this.image,
    required this.name,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.description,
    this.showDescription=false
  });
}

class DietData{
  static List<Diet> dietData=[
    Diet(
      id: "1",
        image: AssetsLocation.noJunkImageLocation,
        name: "No Junk",
        protein: "",
        fat: "",
        carbs: "",
        description: "Just eat no junk and collect score. That's all.",
      showDescription: true
    ),
    Diet(

        id: "2",
        image: AssetsLocation.breakfastImageLocation,
        name: "Breakfast",
        protein: "25 g",
        fat: "25 g",
        carbs: "25 g",
        description: ""
    ),
    Diet(

        id: "3",
        image: AssetsLocation.snacksImageLocation,
        name: "All Snacks",
        protein: "25 g",
        fat: "25 g",
        carbs: "25 g",
        description: ""
    ),
    Diet(

        id: "4",
        image: AssetsLocation.dinnerImageLocation,
        name: "Dinner",
        protein: "25 g",
        fat: "25 g",
        carbs: "25 g",
        description: ""
    ),
  ];
}