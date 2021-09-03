class Contribution {
  final String player;
  final String cityName;
  final String option;
  final String textContent;
  

  Contribution.fromMap(final Map<String, dynamic> payload)
      : this.player = payload['player'],
        this.cityName = payload['cityName'],
        this.option = payload['option'],
        this.textContent = payload['textContent'];
}

class PlayerContribution {
  final List<Contribution> contributions;

  PlayerContribution.fromMap(final Map<String, dynamic> payload)
      : this.contributions = ((payload['contributions'] ?? []) as List)
            .map((e) => Contribution.fromMap(e))
            .toList();


  

          
}
