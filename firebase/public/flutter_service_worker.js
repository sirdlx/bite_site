'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "a1992e97e711098c245054ec3fd4149d",
"assets/assets/images/beef1.jpg": "03287ccbcd55c911ab883320bd5defdf",
"assets/assets/images/burritos.jpg": "efa29c5f01beb00251f2cd1855c31bad",
"assets/assets/images/Chicken-Chimichanga-Recipe-tasteandtellblog.com-1-768x512.jpg": "468aae737f48c0e289f29d9f5fc50783",
"assets/assets/images/Delicious-Mexican-Salad-Recipe-600x900.jpg": "57402faa4bada7c6261ba94dff07bf04",
"assets/assets/images/deserts.jpg": "64c2537d7aced00c7d163aee9bbcbde0",
"assets/assets/images/drinks.jpg": "c46bc42490729c049528709b86fed1d4",
"assets/assets/images/flour-tortillas-11-600x900.jpg": "96d7e48ab8272bb233cf6bccb6f2e337",
"assets/assets/images/Green-Chile-Chicken-Smothered-Burritos-edit-190-684x1024.jpg": "a164556c5cc95c85e496413f0ed1f57f",
"assets/assets/images/Ground-Beef-Enchiladas-9.jpg": "f6e4baf92c86f9c1bd9f9347d53f7a15",
"assets/assets/images/Habanero-Skirt-Steak-Burritos-01_wide_1920-1-520x520.jpg": "81f58f92759e63ea10b72df1b9b1004f",
"assets/assets/images/logo.png": "90107a0c0283297a3e89634a4e588145",
"assets/assets/images/Mexican-Carne-Asada-Street-Tacos.jpg": "b28cf810a441f85745467f35aeb387e8",
"assets/assets/images/Mexican-Ground-Beef-with-Olives-Chips_hxx0oeL.jpg": "d9b2d2a9d9c7d34769eeb83ffa1516be",
"assets/assets/images/pexels-polina-tankilevitch-5848046.jpg": "5a99c0fa68693a45717267a8ebde7c2d",
"assets/assets/images/pexels-raduz-58722.jpg": "78a6b8d8af11b83eb00d18561bb1ba59",
"assets/assets/images/pexels-rodnae-productions-5737241.jpg": "257008ddd2520f102cf47516b0f1e40d",
"assets/assets/images/tacos.jpg": "108774d15495d2651cc54c7e31669631",
"assets/assets/logos/facebook.jpg": "e78b8801fec15b36530841424b13057d",
"assets/assets/logos/google.jpg": "d0991539b51f1520c42d1dee04ba0faa",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "37b8b406ff5a51dfa929020e89b4b133",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flavor_client/assets/flavor.json": "47a1308423049d45a24b792ac3fa3969",
"assets/packages/flavor_client/assets/flavor.new.json": "0e3e1bef0f5b28b4a42dea0ccbaa7232",
"assets/packages/flavor_client/assets/images/dlxborder.svg": "006b57ae605ddf58db08bdb2b23fcf13",
"assets/packages/flavor_client/assets/images/dlx_bg_4k.png": "a437a5ba7a399af16c32645abb6caa7f",
"assets/packages/flavor_client/assets/images/Eff.png": "24264bdd777154b6476f108e4ef2a217",
"assets/packages/flavor_client/assets/images/Eff.svg": "f275c2d902b803594ef819d7e1dea3c0",
"assets/packages/flavor_client/assets/images/Eff_Full.png": "53c1d2fbf346d7d1d415371090ca733b",
"assets/packages/flavor_client/assets/images/Letter.png": "987a8aa61ec257070efbf660c7b072e9",
"assets/packages/flavor_client/assets/images/logo_top.png": "a0b6eec5e7b64c45a4e203572ed4d7d6",
"assets/packages/flavor_client/assets/images/people/p1.jfif": "d505db9327701aa50143ad33fe65610c",
"assets/packages/flavor_client/assets/images/people/p2.jfif": "543c1d8970258c15b6d7dab89a99b73f",
"assets/packages/flavor_client/assets/images/people/p3.jfif": "7a4460f9b2273dcdf26478e59a2287fe",
"assets/packages/flavor_client/assets/images/people/p4.jfif": "59e4e4727de920d6919713f7ce8661e5",
"assets/packages/flavor_client/assets/images/people/p5.jfif": "d15ebf41fe70618177c25775d1fdad7f",
"assets/packages/flavor_client/assets/images/people/p6.jfif": "a5d9d5857c8507af78e82550e5266de7",
"assets/packages/flavor_client/assets/images/people/p7.jfif": "de00a304609d83148829ece2a7939b39",
"assets/packages/flavor_client/assets/images/people/sir.backdrop.jpg": "d86947be8917f94c3e682bcfac083d8d",
"assets/packages/flavor_client/assets/images/people/sir.cover.jpg": "8f314d374af694327cab9daa7e88f37c",
"assets/packages/flavor_client/assets/images/saucetv_logo.svg": "b5467c9102d03d462645d02ef75ef16c",
"assets/packages/flavor_client/assets/images/saucetv_wallpaper-01.png": "5e937a05544dd014437ab52ca50a9214",
"assets/packages/flavor_client/assets/images/saucetv_wallpaper.ai": "4184dad4667d89577a8de266d3012e2a",
"assets/packages/flavor_client/assets/images/saucetv_wallpaper_red.png": "e7033af22cf4422ec97c8834f7a2844d",
"assets/packages/flavor_client/assets/marvel.json": "d41d8cd98f00b204e9800998ecf8427e",
"assets/packages/flavor_client/assets/settings.json": "882c2adbe72c511454b4dbcdba4a4efa",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "63e581a5a4892e92c0dc6ca8d2eae148",
"/": "63e581a5a4892e92c0dc6ca8d2eae148",
"main.dart.js": "d82558e244dff57c3dada51a77e4f026",
"manifest.json": "b1a177c9acaa187b9e1c43f7b1122383",
"version.json": "5ef895555566a890b142a48fca9ccdcc"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
