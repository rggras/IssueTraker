# Lentil Test

##Dependencies##

- Xcode 10+
- Base SDK: iOS 12+
- Target OS: iOS 12 (minimal)
- Cocoapods (CocoaPods is the dependency manager for Objective-C projects)

External Libs by Cocoapods:
see Podfile

##How run app##


1. Install xCode. 

2. Make sure you already installed the Command Line Tools from Xcode. Preference -> Locations

3. Install and setup CocoaPods running the following commands from the terminal:

$ [sudo] gem install cocoapods 
$ pod setup  

For more information go to www.cocoapods.org

4. Restart the terminal and check if it was successfully installed running “pod --version”.

5. Before opening Xcode, from the terminal in root project folder (/IssueTracker) run the following command on your project directory:

$ pod install

6. After CocoaPods downloaded all the dependencies, you should open the .xcworkspace file instead of the .xcodeproj file. 
7. Finally, you should be able to proceed and compile the sources as you normally do.
