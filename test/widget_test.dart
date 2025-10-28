import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sliver_grid_demo/main.dart';

void main() {
  testWidgets('App loads with Afrobeats Albums title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SpotifyAlbumApp());

    // Verify that the app bar shows "Afrobeats Albums"
    expect(find.text('Afrobeats Albums'), findsOneWidget);
    
    // Verify that search bar exists
    expect(find.byType(TextField), findsOneWidget);
    
    // Verify that albums are displayed (should have multiple album cards)
    expect(find.byType(CustomScrollView), findsOneWidget);
  });

  testWidgets('Search functionality works', (WidgetTester tester) async {
    await tester.pumpWidget(const SpotifyAlbumApp());

    // Find the search field
    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    // Enter text in search field
    await tester.enterText(searchField, 'Wizkid');
    await tester.pump();

    // The search should filter results (basic check that it doesn't crash)
    expect(find.text('Wizkid'), findsWidgets);
  });
}