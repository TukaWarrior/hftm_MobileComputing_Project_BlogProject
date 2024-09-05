// Text(
//   'Hello, Flutter!',
//   style: TextStyle(
//     fontFamily: 'Mulish',
//     fontWeight: FontWeight.w400, // Adjust weight here
//     fontStyle: FontStyle.normal, // Or FontStyle.italic
//     fontSize: 20.0, // Adjust the size if needed
//   ),
// ),

// Navigation bar customization:
// https://api.flutter.dev/flutter/material/NavigationBar-class.html

// AnimatedSwitcher:
// Purpose: It is used to switch between two widgets with a transition animation, like a fade or slide. When the widget changes, AnimatedSwitcher automatically animates the old widget out and the new widget in.
// Usage: This is useful when you want to add a subtle transition effect when switching between pages or content to make the UI feel more dynamic.

// PopScope:
// Purpose: PopScope is a custom widget (not part of the standard Flutter library) typically used to handle the back navigation (like the Android back button or swipe-back gesture). It intercepts the back action to determine if it should pop the current page or exit the app.
// Usage: This can be particularly useful when you have a nested navigation structure and want to control how back navigation is handled at different levels of the navigation stack.

// Custom Navigator Implementation:
// Purpose: The custom Navigator with a GlobalKey<NavigatorState> allows each tab in a bottom navigation bar to have its own independent navigation stack. This means you could navigate deeper within a tab, and when you switch tabs, the navigation state for each tab is preserved.
// Usage: This is useful in apps where each tab might have multiple subpages, and you want to retain the back stack independently for each tab. For example, in a shopping app, you might have a Home tab and a Cart tab, and navigating within each should not affect the other's state.

// When Are These Components Needed?
// These components are generally used in more complex apps where:

// Custom Animation Needs: You want to animate transitions between pages or components for a more polished user experience.
// Advanced Navigation Control: Each tab in a bottom navigation bar needs its own navigation history, allowing users to go back within the context of the selected tab.
// Complex Back Navigation: You need fine control over the back button behavior, like preventing accidental exits or managing nested navigators.


// This in appbar for settigns button
// actions: [
//                   IconButton(
//                     icon: const Icon(Icons.settings), // Cogwheel icon
//                     onPressed: () {
//                       // Navigate to the settings page or perform any action
//                       print('Settings button pressed');
//                     },
//                   ),
//                 ],
