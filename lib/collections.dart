class Cards {
  int id;
  String name;
  double chance;
  int dmgLow;
  int dmgHigh;
  Features feature;

  String getDescription() {
    switch (feature) {
      case Features.meleeDefault:
        return "Наносит ${(this.dmgLow).floor()} - ${(this.dmgHigh).floor()} урона";
      case Features.rangedDefault:
        return "С верояьность ${(this.chance * 100).floor()}% нанесет ${(this.dmgLow).floor()} урона.";
      case Features.shieldDefault:
        return "Вы получите ${(this.dmgLow).floor()} брони.";
      case Features.prepareDefault:
        return "Вы получите 1 очко инициативы, и 1 карту на выбор.";

      case Features.curseDefault:
        return "Добавляет 2 карты проклятия в колоду противника.";
      case Features.simpleCurse:
        return "Жалкое проклятие. Просто выбросите и играйте дальше";

      case Features.improvementDefault:
        return "Ваша следующая атака улучшена на ${(this.chance * 100).floor()}%";
      default: return "";
    }
  }

  Cards(this.id, this.name, this.chance, this.dmgLow,
      this.dmgHigh, this.feature);

  static List<Cards> getDefaultCollection() {
    return List.of([
      defaultMeleeCard(), defaultMeleeCard(),
      defaultRangedCard(), defaultRangedCard(),
      defaultShieldCard(), defaultShieldCard(),
      defaultCurseCard(), defaultCurseCard(),
      defaultPrepareCard(), defaultImprovementCard()
    ]);
  }

  static Cards defaultMeleeCard() {
    return Cards(1, "Удар", 1, 2, 12, Features.meleeDefault);
  }

  static Cards defaultRangedCard() {
    return Cards(2, "Выстрел", 0.7, 10, 10, Features.rangedDefault);
  }

  static Cards defaultShieldCard() {
    return Cards(3, "Щит", 1, 8, 12, Features.shieldDefault);
  }

  static Cards defaultPrepareCard() {
    return Cards(4, "Подготовка", 1, 1, 1, Features.prepareDefault);
  }

  static Cards defaultCurseCard() {
    return Cards(5, "Проклятие", 1, 1, 1, Features.curseDefault);
  }

  static Cards simpleCurse() {
    return Cards(5, "Простое проклятие", 1, 1, 1, Features.simpleCurse);
  }

  static Cards defaultImprovementCard() {
    return Cards(6, "Улучшение", 0.5, 1, 1, Features.improvementDefault);
  }

  @override
  String toString() {
    return 'Cards{name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Cards &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;


}

enum Features {
  meleeDefault,
  rangedDefault,
  shieldDefault,
  prepareDefault,
  //Проклятие.
  curseDefault,
  simpleCurse,
  //Улучшение.
  improvementDefault
}