$wgDefaultSkin = "chameleon";
wfLoadSkin('chameleon');
$egChameleonLayoutFile= __DIR__ . '/skins/chameleon/layouts/clean.xml';
$wgArticlePath='/wiki/$1';
$wgMetaNamespace = "Self";
$wgUseSquid = true;
$wgSquidServers = array();
$wgSquidServers[] = "127.0.0.1";
// Extension:MissedPages
wfLoadExtension('MissedPages');
// Extension:SafeDelete
wfLoadExtension('SafeDelete');
$SafeDeleteNamespaces = $wgContentNamespaces;
// Extension:googleAnalytics
require_once "$IP/extensions/googleAnalytics/googleAnalytics.php";
// Replace xxxxxxx-x with YOUR GoogleAnalytics UA number
$wgGoogleAnalyticsAccount = 'UA-49908752-13';
// Add HTML code for any additional web analytics (can be used alone or with $wgGoogleAnalyticsAccount)
$wgGoogleAnalyticsOtherCode = '';
// Optional configuration (for defaults see googleAnalytics.php)
// Store full IP address in Google Universal Analytics (see https://support.google.com/analytics/answer/2763052?hl=en for details)
$wgGoogleAnalyticsAnonymizeIP = false;
// Array with NUMERIC namespace IDs where web analytics code should NOT be included.
$wgGoogleAnalyticsIgnoreNsIDs = array();
// Array with page names (see magic word {{FULLPAGENAME}}) where web analytics code should NOT be included.
$wgGoogleAnalyticsIgnorePages = array();
// Array with special pages where web analytics code should NOT be included.
$wgGoogleAnalyticsIgnoreSpecials = array( 'Userlogin', 'Userlogout', 'Preferences', 'ChangePassword', 'OATH');
// Use 'noanalytics' permission to exclude specific user groups from web analytics, e.g.
$wgGroupPermissions['sysop']['noanalytics'] = true;
// $wgGroupPermissions['bot']['noanalytics'] = true;
// To exclude all logged in users give 'noanalytics' permission to 'user' group, i.e.
// $wgGroupPermissions['user']['noanalytics'] = true;
// Extension:Lingo
wfLoadExtension('Lingo');
$wgMFRemovableClasses = [ 'base' => [ '.mw-lingo-tooltip' ] ];
// Extension:Mermaid
wfLoadExtension('Mermaid');
$mermaidgDefaultTheme = 'forest';
$wgGroupPermissions['*']['createaccount'] = false;
$wgGroupPermissions['*']['edit'] = false;
$wgGroupPermissions['sysop']['edit'] = true;
