import 'package:rick_and_morty/constants/colors.dart';
import 'package:rick_and_morty/constants/strings.dart';
import 'package:rick_and_morty/data/models/characters_model.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final CharactersModel character;

  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          charactersDetailsScreen,
          arguments: character,
        ),
        child: Hero(
          tag: character.id,
          child: GridTile(
            footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: AppColors.background.withValues(alpha: 0.85),
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 20,
                  color: AppColors.text,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: AppColors.background,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            child: Container(
              color: AppColors.card,
              child: character.image.isNotEmpty
                  ? Image.network(
                      character.image,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.card,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.accent,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/images/placeholder.jpg");
                      },
                    )
                  : Image.asset("assets/images/placeholder.jpg"),
            ),
          ),
        ),
      ),
    );
  }
}