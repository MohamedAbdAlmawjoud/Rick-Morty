import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/data/models/characters_model.dart';
import 'package:rick_and_morty/logic/cubit/characters_cubit.dart';
import 'package:rick_and_morty/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<CharactersModel> allCharacters;
  late List<CharactersModel> searchedForCharacters;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _connectivityCheckTimer;
  bool _hasConnection = true;

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: AppColors.accent,
      decoration: InputDecoration(
        hintText: "Find a character...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: AppColors.background, fontSize: 18),
      ),
      style: TextStyle(color: AppColors.background, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: AppColors.background),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(Icons.search, color: AppColors.background),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where(
          (character) =>
              character.name.toLowerCase().startsWith(searchedCharacter),
        )
        .toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
    _checkConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (_) => _checkConnectivity(),
    );
    // A Wi-Fi or mobile connection can remain active while its internet
    // access has been lost, so connectivity_plus alone is not sufficient.
    _connectivityCheckTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkConnectivity(),
    );
  }

  Future<void> _checkConnectivity() async {
    var hasConnection = false;
    Socket? socket;
    try {
      final connectivity = await _connectivity.checkConnectivity();
      if (!connectivity.contains(ConnectivityResult.none)) {
        socket = await Socket.connect(
          'rickandmortyapi.com',
          443,
          timeout: const Duration(seconds: 3),
        );
        hasConnection = true;
      }
    } catch (_) {
      // Treat DNS, socket, and platform-specific probe failures as offline.
      hasConnection = false;
    } finally {
      socket?.destroy();
    }
    if (!mounted || hasConnection == _hasConnection) return;
    setState(() => _hasConnection = hasConnection);
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivityCheckTimer?.cancel();
    _searchTextController.dispose();
    super.dispose();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildCharactersList();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.accent),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: AppColors.background),
    );
  }

  Widget _buildNoInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 20,
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          SvgPicture.asset('assets/images/undraw_no-signal.svg'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: _hasConnection ? buildBlocWidget() : _buildNoInternetWidget(),
      backgroundColor: AppColors.background,
    );
  }
}
