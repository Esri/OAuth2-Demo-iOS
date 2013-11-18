OAuth 2.0 Demo for iOS
======================

This is a simple iPhone app demonstrating how to manually use the ArcGIS OAuth 2.0 API 
to obtain an access token for a user.

When the user clicks the "Sign In" button, the app launches a browser to the ArcGIS 
authorization endpoint.

```objc
    NSURL *url = [NSURL URLWithString:@"https://www.arcgis.com/sharing/oauth2/authorize?"
                  "response_type=token&"
                  "client_id=eKNjzFFjH9A1ysYd&"
                  "redirect_uri=oauthdemo://auth"];
    [[UIApplication sharedApplication] openURL:url];
```

The app sets up a custom protocol handler so that when Safari redirects after authorization
is complete, the app is launched by the `oauthdemo://auth` URL.

When the user finishes signing in, the app is re-launched with the token information 
appended to the redirect URI, which looks something like the following:

```
oauthdemo://auth#access_token=lS0KgilpRsT07qT_iMOg9bBSaWqODC1g061nSLsa8gV2GYtyynB6A-
abCsWrDTvN9p7rI0kWa4u-ORXuFUQ7QGxiiniwpCSIV1AqzoLRHF1hYcI4joeDPOzZa9PZigiudtefciZy5
&expires_in=7199&username=guest
```

The app then parses this out of the query string and stores the token and username in 
the app's preferences file.

```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url 
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if([[url host] isEqualToString:@"auth"]) {
        NSDictionary *params = [self parseQueryString:[[url fragment] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

        // Store the access token
        [[NSUserDefaults standardUserDefaults] setObject:[params objectForKey:@"access_token"] forKey:OADTokenDefaultsName];

        // Calculate the expiration date so we know if the token is invalid
        NSDate *expDate = [NSDate dateWithTimeIntervalSinceNow:[[params objectForKey:@"expires_in"] integerValue]];
        [[NSUserDefaults standardUserDefaults] setObject:expDate forKey:OADTokenExpirationDefaultsName];

        // Store the username
        [[NSUserDefaults standardUserDefaults] setObject:[params objectForKey:@"username"] forKey:OADUsernameDefaultsName];

        // Save
        [[NSUserDefaults standardUserDefaults] synchronize];

        // Notify the view that a new token is available
        [[NSNotificationCenter defaultCenter] postNotificationName:OADNewTokenAvailable object:self];
    }    
    return YES;
}
```

The app can now continue to operate by using the access token wherever is needed!

