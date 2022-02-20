import 'package:digi3map/data/services/assets_location.dart';
import 'package:digi3map/screens/group_portle/view/effects_testing_page.dart';

class EffectModel{
  String imageLocation,name,symbolicName,description,soundLocation;
  EffectType effectType;
  int id,trophy;
  EffectModel({
    required this.id,
    required this.imageLocation,
    required this.name,
    required this.symbolicName,
    required this.description,
    required this.trophy,
    required this.soundLocation,
    required this.effectType
  });
}


class EffectData{
  static const recommendedEffectId=3;
  static List<EffectModel> effectData=[
    EffectModel(
        id: 1,
        imageLocation: AssetsLocation.deathImageLocation,
        name: "Monkey's Mind",
        symbolicName: "Death",
        description: "There is nothing left inside. Now stop searching...",
        trophy: 1,
        soundLocation: AssetsLocation.deathAudioLocation,
      effectType: EffectType.death
    ),
    EffectModel(
        id: 2,
        imageLocation: AssetsLocation.sanityImageLocation,
        name: "Crystal's Lighting",
        symbolicName: "Sanity",
        description: "Energy is supposed to flow from inside out, now run Barry run!!",
        trophy: 1,
        soundLocation: AssetsLocation.sanityAudioLocation,
      effectType: EffectType.sanity
    ),
    EffectModel(
        id: 3,
        imageLocation: AssetsLocation.vengeanceImageLocation,
        name: "Fire of Vengeance",
        symbolicName: "Justice",
        description: "I felt bad, now hands down!!",
        trophy: 2,
        soundLocation: AssetsLocation.vengeanceAudioLocation,
      effectType: EffectType.vengeance
    ),
    EffectModel(
        id: 4,
        imageLocation: AssetsLocation.passionImageLocation,
        name: "Fire of Passion",
        symbolicName: "Life",
        description: "Are Ya Winning Son?",
        trophy: 2,
        soundLocation: AssetsLocation.passionAudioLocation,
      effectType: EffectType.passion
    ),
    EffectModel(
        id: 5,
        imageLocation: AssetsLocation.hopeImageLocation,
        name: "Last Smile?",
        symbolicName: "Symbol of Hope",
        description: "What am I supposed to do, just let me die?",
        trophy: 2,
        soundLocation: AssetsLocation.hopeAudioLocation,
      effectType: EffectType.hope
    ),
  ];
}