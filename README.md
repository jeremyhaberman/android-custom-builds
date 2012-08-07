android-custom-builds
=====================

This sample project shows one method for creating a custom build script for Android.

Why?  Maybe you have an app that uses an API, which has multiple installations: test, QA and production. And you want to control the app's behavior at build time versus having to manually update variables in the code, which not only time consuming but error-prone.

The sample **release.sh** script does a few things, including:

* Modifying the value of a Java constant
* Copying an Android XML resource file into **res/values**
* Renaming the output APK file

To see it in action:

1. Build the app by running the script with the "qa" config:

        ./release.sh qa

2. Install and run the app, and note the values of "System" and "In production."
3. Run the script with the "production" config:

        ./release.sh production

4. Re-install and run the app.  Note the updates values.