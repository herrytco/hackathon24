List<Ngo> ngos = [
  Ngo(
    "TiKo - Tierheim in Klagenfurt",
    "tiko.jpg",
    "Das TierschutzKompetenzzentrum des Landestierschutzvereins Kärnten kümmert sich um Tiervermittlung und Rettung u. a. von Hunden und Katzen. Verantwortungsvoller Tierschutz ist uns österreichweit ein Anliegen. Bitte helfen Sie uns dabei mit Ihrer Spende!",
  ),
  Ngo(
    "SOS Kinderdorf",
    "sos.png",
    "Jeden Tag verlieren Kinder und Jugendliche ihr Zuhause - und damit ihre Kindheit. SOS-Kinderdorf hilft mit Ihrer Spende Kindern und Familien in Not - bedingungslos! Denn eine geglückte Kindheit hilft ein Leben lang.",
  ),
  Ngo(
    "Caritas",
    "caritas.png",
    "Der Bedarf an Spenden ist so groß wie unsere Einrichtungen, vor allem im Bereich der Hilfe für Menschen in Not und für wohnungs- und obdachlose Menschen sind wir immer wieder auf der Suche nach Spenden.",
  ),
];

class Ngo {
  final String name;
  final String asset;
  final String message;

  Ngo(this.name, this.asset, this.message);
}
