class _Contribution {
  final String option;
  final String textContent;

  _Contribution.fromMap(final Map<String, dynamic> payload)
      : this.option = payload['option'],
        this.textContent = payload['textContent'];
}

class PlayerContribution {
  final bool contributed;
  final List<_Contribution> contributions;
  final String cityName;

  PlayerContribution.fromMap(final Map<String, dynamic> payload, String cityName)
      : this.contributed = payload['contributed'],
        this.cityName = payload['cityName'],
        this.contributions = ((payload['contributions'] ?? []) as List)
            .map((e) => _Contribution.fromMap(e))
            .toList();
}
