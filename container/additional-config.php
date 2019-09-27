$wgDefaultSkin = "chameleon";
wfLoadSkin( 'chameleon' );
$egChameleonLayoutFile= __DIR__ . '/skins/chameleon/layouts/clean.xml';
$wgArticlePath='/wiki/$1';
$wgMetaNamespace = "Self";
$wgUseSquid = true;
$wgSquidServers = array();
$wgSquidServers[] = "127.0.0.1";
