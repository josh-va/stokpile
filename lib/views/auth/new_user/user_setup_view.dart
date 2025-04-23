import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stokpile/enums/entry_type_enum.dart';
import 'package:stokpile/services/cloud/favorite.dart';
import 'package:stokpile/services/profile/bloc/profile_bloc.dart';
import 'package:stokpile/services/logout_blocs.dart';
import 'package:stokpile/views/auth/new_user/user_setup_favorite.dart';
import 'package:stokpile/views/auth/new_user/user_setup_name.dart';

class UserSetupView extends StatefulWidget {
  const UserSetupView({super.key});

  @override
  State<UserSetupView> createState() => _UserSetupViewState();
}

class _UserSetupViewState extends State<UserSetupView> {
  final _pageViewController = PageController();
  int _currentPage = 0;

  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _favoriteSaveFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _favoriteSpendFormKey = GlobalKey<FormState>();

  String? _name;

  String? _favoriteSaveTitle;
  num? _favoriteSaveValue;

  String? _favoriteSpendTitle;
  num? _favoriteSpendValue;

  bool _isFormValid(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form != null && form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void _saveForm(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    form!.save();
  }

  @override
  void initState() {
    _pageViewController.addListener(() {
      setState(() {
        _currentPage = _pageViewController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Setup'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              logoutAllBlocs(context);
            },
          ),
        ),
        body: PageView(
          controller: _pageViewController,
          children: [
            UserSetupName(
              formKey: _nameFormKey,
              onSaved: (name) => _name = name,
            ),
            UserSetupFavorite(
              formKey: _favoriteSaveFormKey,
              type: EntryType.save.name,
              onSaved: (title, value) {
                if (value != null) _favoriteSaveValue = value;
                if (title != null) _favoriteSaveTitle = title;
              },
            ),
            UserSetupFavorite(
              formKey: _favoriteSpendFormKey,
              type: EntryType.spend.name,
              onSaved: (title, value) {
                if (value != null) _favoriteSpendValue = value;
                if (title != null) _favoriteSpendTitle = title;
              },
            )
          ],
          onPageChanged: (page) {
            setState(() {
              _currentPage = page;
            });
          },
        ),
        floatingActionButton: floatingActionButton(_currentPage));
  }

  floatingActionButton(int page) {
    switch (page) {
      case 0:
        return nextFAB(page);
      case 1:
        return nextFAB(page);
      case 2:
        return submitFAB();
      default:
    }
  }

  FloatingActionButton submitFAB() {
    return FloatingActionButton(
      child: const Icon(Icons.done_rounded),
      onPressed: () {
        if (_isFormValid(_favoriteSpendFormKey)) {
          _saveForm(_favoriteSpendFormKey);
          setUpProfile();
        }
      },
    );
  }

  void setUpProfile() {
    final favSave = Favorite(
        title: _favoriteSaveTitle!,
        value: _favoriteSaveValue!,
        type: EntryType.save);
    final favSpend = Favorite(
        title: _favoriteSpendTitle!,
        value: _favoriteSpendValue!,
        type: EntryType.spend);
    context.read<ProfileBloc>().add(ProfileEventSetUpProfile(
          name: _name!,
          save: favSave,
          spend: favSpend,
        ));
  }

  FloatingActionButton nextFAB(int page) {
    final formKey = getPageFormKey(page);
    return FloatingActionButton(
      child: const Icon(Icons.navigate_next_rounded),
      onPressed: () {
        if (_isFormValid(formKey)) {
          _saveForm(formKey);
          _pageViewController.nextPage(
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        }
      },
    );
  }

  getPageFormKey(int page) {
    switch (page) {
      case 0:
        return _nameFormKey;
      case 1:
        return _favoriteSaveFormKey;
      case 2:
        return _favoriteSpendFormKey;
      default:
        Exception();
    }
  }
}
