import 'package:flutter/material.dart';
import 'package:stokpile/constants/user_setup_constants.dart';

class UserSetupFavorite extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String type;
  final Function(
    String? title,
    num? value,
  ) onSaved;

  const UserSetupFavorite({
    required this.formKey,
    required this.type,
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FavoriteTitleFormField(
                type: type,
                onSaved: onSaved,
              ),
              FavoriteValueFormField(
                onSaved: onSaved,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteValueFormField extends StatelessWidget {
  const FavoriteValueFormField({
    super.key,
    required this.onSaved,
  });

  final Function(String? title, num? value) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: valueFavFormHintText),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return valueFavFormEmptyErrorText;
        }
        final valueAsNum = num.tryParse(value);
        if (valueAsNum == null) {
          return valueFavFormNotNumErrorText;
        } else if (valueAsNum == 0) {
          return valueFavFormZeroErrorText;
        } else {
          return null;
        }
      },
      onSaved: (value) {
        final valueAsNum = num.parse(value!);
        onSaved(null, valueAsNum);
      },
    );
  }
}

class FavoriteTitleFormField extends StatelessWidget {
  const FavoriteTitleFormField({
    required this.type,
    super.key,
    required this.onSaved,
  });
  final String type;
  final Function(
    String? title,
    num? value,
  ) onSaved;

  @override
  Widget build(BuildContext context) {
    final titleHintText = getFavFormTitleHintText();
    return TextFormField(
      decoration: InputDecoration(labelText: titleHintText),
      textCapitalization: TextCapitalization.sentences,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return titleFavFormErrorText;
        } else {
          return null;
        }
      },
      onSaved: (value) {
        onSaved(value, null);
      },
    );
  }

  String getFavFormTitleHintText() {
    if (type == 'save') {
      return saveFavFormTitleHintText;
    } else {
      return spendFavFormTitleHintText;
    }
  }
}
