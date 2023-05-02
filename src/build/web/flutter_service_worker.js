'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "8300995021a10a46042e5d98b31ecb3c",
"assets/assets/earth/4096_bump.jpg": "0eb50b4bff2c5a23a011f5a35e27f8dd",
"assets/assets/earth/4096_clouds.jpg": "4d7a77dd09da435802cbade4a651dce5",
"assets/assets/earth/4096_clouds.png": "e0a9fa6e750a1e2478f6263744d84da5",
"assets/assets/earth/4096_earth.jpg": "cd4dc98debcbd1309465b4b194e5fc31",
"assets/assets/earth/4096_night_lights.jpg": "54ccbb8cb3ff8d7ecb8de45977e325b9",
"assets/assets/earth/4096_normal.jpg": "cb6d4b725217e42e5f9cd9e83abb4a03",
"assets/assets/earth/earth.mtl": "e634cef567ff1720d4d677f1c301fbe7",
"assets/assets/earth/earth.obj": "bfaff4c91bb0481c3bf0090556787b15",
"assets/assets/RiveAssets/icons.riv": "162e8114717a3e37193d6c11d805571a",
"assets/assets/RiveAssets/sideMenuButton.riv": "f8fdfd9fd8dc7873dfac6f005f3233c1",
"assets/assets/weather/50.png": "41a5146dbeea339e8713d43c157a20a7",
"assets/assets/weather/clouds.png": "86cef8cc1b33b80a8fb1c7f1d55f9f4a",
"assets/assets/weather/darkSky.png": "542aec04664d6cbb94c19c75250129cf",
"assets/assets/weather/earth_spin.gif": "07d46ca3acb5998bcfaba95b08ec0b82",
"assets/assets/weather/ground.jpg": "1aacf33f7158435248b954c593b03db9",
"assets/assets/weather/moon.png": "ca71cf762bb560aec2392efc4191d9f3",
"assets/assets/weather/nightxpgrass.png": "84927e82fa3c22a6d003ac29271ccd19",
"assets/assets/weather/observatory.jpg": "1e80519df245d1569113127cf92e9cb9",
"assets/assets/weather/picker.png": "fbda03a31b58c88911651eeacefdda7c",
"assets/assets/weather/sun.png": "11a30d16c9a4cc48edf5612dedc3cbe5",
"assets/assets/weather/testClouds.png": "eb4d17e6979d5281fbe6671c495f5290",
"assets/assets/weather/wind.png": "f5788f92b66f3b79b1a1c18919838ac9",
"assets/assets/weather/xpgrass.png": "41576969bea434d2edc27413f0ccf11b",
"assets/FontManifest.json": "f6e4911dfb859712cfe808a42bed8b77",
"assets/Fonts/KdamThmorPro-Regular.ttf": "7f30542a7d396654b40db106fcf9acf9",
"assets/Fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/NOTICES": "a3d1dcc3c847079b1d7d55296f8a7f3a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/line_icons/lib/assets/fonts/LineIcons.ttf": "23621397bc1906a79180a918e98f35b2",
"assets/packages/neon/lib/fonts/Automania/Automania.ttf": "3baf3e2ca3c97dc06fcd1332b7fa0d73",
"assets/packages/neon/lib/fonts/Beon/Beon.otf": "725bc066722fdfc327f582568e8ce97e",
"assets/packages/neon/lib/fonts/Cyberpunk/Cyberpunk.ttf": "9deb7d5fae2c035eb8b7d35f62169309",
"assets/packages/neon/lib/fonts/LasEnter/LasEnter.ttf": "c161024b53fd9d99a60fa0ebc0a587fb",
"assets/packages/neon/lib/fonts/Membra/Membra.ttf": "e378d80f5875e9095843e141e283897e",
"assets/packages/neon/lib/fonts/Monoton/Monoton-Regular.ttf": "f6aa15866bffca161454d7554a004259",
"assets/packages/neon/lib/fonts/Night-Club-70s/Night-Club-70s-Bold.ttf": "c06f06e0a1b9e7bdb9ece19e455ae9cb",
"assets/packages/neon/lib/fonts/Night-Club-70s/Night-Club-70s-Regular.ttf": "2f52ea89848cc22583a19a3517387465",
"assets/packages/neon/lib/fonts/Samarin/Samarin.ttf": "e86112fa7734f71b0292102dfb322181",
"assets/packages/neon/lib/fonts/TextMeOne/TextMeOne-Regular.ttf": "475b539094d914ff68e420b4571c96c3",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "7cc3a89832c16aed4fc579781b5ab234",
"/": "7cc3a89832c16aed4fc579781b5ab234",
"main.dart.js": "852c12e9ed4f3bbab63a281be87b5dd7",
"manifest.json": "d3f7f287821bb2b57bcd88b716433913",
"version.json": "29c2b673436decf3ab18b90b49a3976b"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
