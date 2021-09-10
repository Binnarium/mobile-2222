import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player-search-query.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/search-players.service.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SearchPlayersWidget extends StatefulWidget {
  final Function(List<PlayerModel>?) onValueChange;

  SearchPlayersWidget({
    Key? key,
    required this.onValueChange,
  }) : super(key: key);

  @override
  _SearchPlayersWidgetState createState() => _SearchPlayersWidgetState();
}

class _SearchPlayersWidgetState extends State<SearchPlayersWidget> {
  final TextEditingController _searchController = TextEditingController();

  final Subject<String?> _searchValue = BehaviorSubject<String?>();

  @override
  void initState() {
    super.initState();

    /// emit values every 2 seconds
    this
        ._searchValue
        .debounceTime(Duration(microseconds: 500))
        .startWith(null)
        .asyncMap(
          (value) async {
            if (value == null) return null;
            return await this
                ._searchPlayerService
                .search(PlayerSearchQueryModel(query: value));
          },
        )
        .asyncMap<List<PlayerModel?>?>(
          (results) {
            if (results == null) return null;
            final loadTask = results
                .map((e) async => await this._playerService.load$(e.uid).first);
            return Future.wait(loadTask);
          },
        )
        .map(
          (players) => players?.whereNotNull().toList(),
        )
        .listen((event) => this.widget.onValueChange(event));
  }

  @override
  void deactivate() {
    this._searchValue.close();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField222(
      controller: this._searchController,
      label: 'Buscar viajeros',
      prefixIcon: Icons.search,
      onValueChanged: (value) =>
          this._searchValue.add((value?.length ?? 0) > 0 ? value : null),
    );
  }

  SearchPlayersService get _searchPlayerService =>
      Provider.of<SearchPlayersService>(context, listen: false);

  LoadPlayerService get _playerService =>
      Provider.of<LoadPlayerService>(context, listen: false);
}
