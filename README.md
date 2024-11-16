# Task Manager App

## Overview
This is a Flutter-based task manager app designed to help users manage their tasks efficiently. It allows users to create, update, and track tasks, as well as manage their profile and reset their password. The app includes various functionalities like task statuses, progress tracking, and user authentication via email.

### Features
- **User Authentication:** Sign up, login, forgot password, and reset password functionality.
- **Task Management:** 
  - Add new tasks
  - View and manage completed/cancelled tasks
  - Track task progress
  - View task summaries and statuses
- **Profile Management:** Update user profile.
- **Task Status Tracking:** Easily switch between tasks in different states such as pending, completed, or cancelled.
- **Custom Widgets:** Custom task card, summary section, progress indicator, snackbars, and app bar.

## Screens

- **Splash Screen:** Initial screen shown when the app is launched.
- **Sign In / Sign Up:** User authentication with email.
- **Forget Password:** Allows the user to reset their password by entering an OTP sent to their email.
- **Task Management:** Screens to add, view, update, or cancel tasks.
- **Profile:** A screen to update user information.
- **Task Progress:** A visual representation of the task progress.

## Technologies Used
- **Flutter:** Cross-platform mobile development framework.
- **Dart:** Programming language for Flutter.
- **API Integration:** Uses network calls to fetch and manage data.
- **State Management:** Uses controllers to manage task and user states.

## Dependencies

The project relies on the following dependencies:

- **flutter_svg:** `^2.0.10+1` – SVG support in Flutter.
- **pin_code_fields:** `^8.0.1` – OTP input field for user authentication.
- **http:** `^1.2.2` – For making network requests.
- **shared_preferences:** `^2.3.2` – To store simple data like user credentials locally.
- **image_picker:** `^1.1.2` – For picking images from the gallery or camera.
- **lottie:** `^3.1.3` – For adding animations.
- **introduction_screen:** `^3.1.14` – To create onboarding screens for new users.



## Setup Instructions


To run this project locally:

### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Dart comes bundled with Flutter.




### Clone the Repository

```bash
git clone https://github.com/IbsharIbnaEbad/Task_Manager_Project.git
cd Task_Manager_Project



