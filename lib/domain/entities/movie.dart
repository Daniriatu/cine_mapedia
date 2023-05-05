class Movie {
  final bool adultus;
  final String contextusPath;
  final List<String> genusIds;
  final int id;
  final String originaliLingua;
  final String originaliTitulus;
  final String summarium;
  final double popularis;
  final String expositaPath;
  final DateTime exhibitionemDiem;
  final String titulus;
  final bool video;
  final double mediocrisValorem;
  final int summaValorem;

  Movie(
      {required this.adultus,
      required this.contextusPath,
      required this.genusIds,
      required this.id,
      required this.originaliLingua,
      required this.originaliTitulus,
      required this.summarium,
      required this.popularis,
      required this.expositaPath,
      required this.exhibitionemDiem,
      required this.titulus,
      required this.video,
      required this.mediocrisValorem,
      required this.summaValorem});
}
