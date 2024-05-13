import 'package:flutter/material.dart';

Widget Autocomplete_text_Widget(alaramProvider) {
  return RawAutocomplete(
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '') {
        return const Iterable<String>.empty();
      } else {
        List<String> matches = <String>[];
        matches.addAll(alaramProvider.locationSuggestion);
        matches.retainWhere((s) {
          return s
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
        return matches;
      }
    },
    onSelected: (String selection) {
      alaramProvider.destination.text = selection;
    },
    fieldViewBuilder: (BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted) {
      return TextField(
        decoration: const InputDecoration(
            labelText: 'Destination', border: OutlineInputBorder()),
        controller: textEditingController,
        focusNode: focusNode,
        onSubmitted: (String value) {},
      );
    },
    optionsViewBuilder: (BuildContext context,
        void Function(String) onSelected, Iterable<String> options) {
      return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topRight, colors: [
                Colors.white.withOpacity(.9),
                Colors.grey.withOpacity(1),
              ])),
          child: SizedBox(
              height: 200,
              child: SingleChildScrollView(
                  child: Column(
                    children: options.map((opt) {
                      return InkWell(
                          onTap: () {
                            onSelected(opt);
                          },
                          child: Container(
                              padding: const EdgeInsets.only(right: 30),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  opt,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              )));
                    }).toList(),
                  ))));
    },
  );
}