enum NewsCategory {
  politics('Politics'),
  artsCultureAndEntertainment(
    'Arts, Culture and Entertainment',
  ),
  crimeLawAndJustice('Crime, Law and Justice'),
  economy('Education'),
  disasterAndAccident('Disaster and Accident'),
  environment('Environment'),
  health('Health'),
  humanInterest('Human Interest'),
  warConflictAndUnrest('War, Conflict and Unrest'),
  socialIssue('Social Issue'),
  scienceAndTechnology('Science and Technology'),
  businessFinance('Economy, Business and Finance'),
  scienceTechnology('Sport'),
  crime('Crime'),
  labor('Labor'),
  lifestyleAndleisure('Lifestyle and Leisure'),
  religionAndBelief('Religion and Belief'),
  weather('Weather');

  String get emoji {
    switch (this) {
      case NewsCategory.politics:
        return '🏛️';
      case NewsCategory.artsCultureAndEntertainment:
        return '🎭';
      case NewsCategory.crimeLawAndJustice:
        return '⚖️';
      case NewsCategory.economy:
      case NewsCategory.businessFinance:
        return '💰';
      case NewsCategory.disasterAndAccident:
        return '🚨';
      case NewsCategory.environment:
        return '🌿';
      case NewsCategory.health:
        return '🩺';
      case NewsCategory.humanInterest:
        return '💬';
      case NewsCategory.warConflictAndUnrest:
        return '⚔️';
      case NewsCategory.socialIssue:
        return '🤝';
      case NewsCategory.scienceAndTechnology:
      case NewsCategory.scienceTechnology:
        return '🧬';
      case NewsCategory.crime:
        return '🚓';
      case NewsCategory.labor:
        return '👷';
      case NewsCategory.lifestyleAndleisure:
        return '🏖️';
      case NewsCategory.religionAndBelief:
        return '🙏';
      case NewsCategory.weather:
        return '⛅';
    }
  }

  final String value;
  const NewsCategory(this.value);
}
