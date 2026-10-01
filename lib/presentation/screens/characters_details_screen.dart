import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/data/models/characters_model.dart';
import 'package:flutter/material.dart';

class CharactersDetails extends StatelessWidget {
  final CharactersModel character;

  const CharactersDetails({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.name,
          style: const TextStyle(color: AppColors.background, fontSize: 20 , fontWeight: FontWeight.bold ,),
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Divider(
      color: AppColors.primary,
      height: 30, 
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
                padding: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('species : ', character.species),
                    buildDivider( ),
                    characterInfo(
                      'gender : ',
                      character.gender,
                    ),
                    buildDivider(),
                    characterInfo(
                      'Episodes : ',
                      character.episode.length.toString(),
                    ),
                    buildDivider(),
                    characterInfo('Status : ', character.status),
                    buildDivider(),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
              const SizedBox(height: 600),
            ]),
          ),
        ],
      ),
    );
  }
}
