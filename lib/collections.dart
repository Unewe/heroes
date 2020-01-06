
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
        return "Наносит ${this.dmgLow} - ${this.dmgHigh} урона";
      case Features.rangedDefault:
        return "С верояьность ${this.chance * 100}% нанесет ${this.dmgLow} урона.";
      case Features.shieldDefault:
        return "Вы получите ${this.dmgLow} брони.";
      case Features.prepareDefault:
        return "Вы получите 1 очко инициативы, и 1 дополнительную катру.";
      case Features.curseDefault:
        return "Добавляет 2 катты проклятия в колоду противника.";
      case Features.improvementDefault:
        return "Ваша следующая атака улучшена на ${this.chance}%";
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
    return Cards(3, "Щит", 1, 10, 10, Features.shieldDefault);
  }

  static Cards defaultPrepareCard() {
    return Cards(4, "Подготовка", 1, 1, 1, Features.prepareDefault);
  }

  static Cards defaultCurseCard() {
    return Cards(5, "Проклятие", 1, 1, 1, Features.curseDefault);
  }

  static Cards defaultImprovementCard() {
    return Cards(6, "Улучшение", 0.5, 1, 1, Features.improvementDefault);
  }
}

enum Features {
  meleeDefault,
  rangedDefault,
  shieldDefault,
  prepareDefault,
  curseDefault,
  improvementDefault
}