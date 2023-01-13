# ios-conf-sg-2023-demo

👋 Hello fellow developer,

This is the demo app accompanying my talk on Firebase Dynamic Links at iOSConfSG 2023.

# Setup

You can download and use the code freely, but before you can run the app and see it working, there are a couple of steps you need to do.

## Google-Info.plist file

You need to create your own project on Firebase and import the **Google-Info.plist** file.

## Associated Domains

The project is missing **entitlements for associated domains**, so you'll have to add those in your Xcode project.

Example used in presentation `applinks:caffeswift.page.link`.

Replace `caffeswift.page.link` with the URL you'll use for your dynamic link. This could be a custom domain or the one you create when you first open Dynamic Links in the Firebase Console.

---

Please know that this is one of the ways you can implement dynamic links in multiple ways. This is one of the examples.

Hope you've enjoyed my talk and happy coding!