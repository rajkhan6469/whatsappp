const CACHE_VERSION = 172,
	CURRENT_CACHES = {
		prefetch: "gdplayer-v" + CACHE_VERSION,
		dynamic: "gdplayer-dynamic-v" + CACHE_VERSION,
	},
	css = [
		"./assets/css/bs-dark-v1.3.1.css",
		"./assets/css/bs-dark-v1.3.1.min.css",
		"./assets/css/player-v3.3.6.css",
		"./assets/css/player-v3.3.6.min.css",
		"./assets/css/skin/jwplayer/lulustream.css",
		"./assets/css/skin/jwplayer/dropload.css",
		"./assets/css/skin/jwplayer/hotstar.css",
		"./assets/css/skin/jwplayer/iqiyi.css",
		"./assets/css/skin/jwplayer/netflix.css",
		"./themes/frontend/default/assets/css/style-v3.4.1.css",
		"./themes/frontend/default/assets/css/style-v3.4.1.min.css",
		"./themes/backend/default/assets/css/style-v3.4.1.css",
		"./themes/backend/default/assets/css/style-v3.4.1.min.css",
	],
	js = [
		"./assets/js/codecs-audio.js",
		"./assets/js/download-v3.2.9.min.js",
		"./assets/js/download-v3.2.9-md.min.js",
		"./assets/js/main-v3.8.js",
		"./assets/js/main-v3.8.min.js",
		"./assets/js/md5.js",
		"./assets/js/player-v4.5.0.min.js",
		"./assets/js/player-v4.5.0-md.min.js",
		"./assets/js/shaka-player-error-codes.js",
		"./assets/vendor/dd.js",
		"./assets/vendor/FormData.js",
	],
	img = [
		"./assets/img/plyr-custom.svg",
		"./assets/img/logo/filemoon.png",
		"./assets/img/logo/vk.png",
		"./assets/img/logo/amazon.png",
		"./assets/img/logo/anonfile.png",
		"./assets/img/logo/archive.png",
		"./assets/img/logo/bayfiles.png",
		"./assets/img/logo/blogger.png",
		"./assets/img/logo/dailymotion.png",
		"./assets/img/logo/direct.png",
		"./assets/img/logo/dropbox.png",
		"./assets/img/logo/facebook.png",
		"./assets/img/logo/fembed.png",
		"./assets/img/logo/filecm.png",
		"./assets/img/logo/filerio.png",
		"./assets/img/logo/filesfm.png",
		"./assets/img/logo/filesim.png",
		"./assets/img/logo/fireload.png",
		"./assets/img/logo/gdrive.png",
		"./assets/img/logo/gofile.png",
		"./assets/img/logo/googlephotos.png",
		"./assets/img/logo/hexupload.png",
		"./assets/img/logo/hxfile.png",
		"./assets/img/logo/indishare.png",
		"./assets/img/logo/mediafire.png",
		"./assets/img/logo/mixdrop.png",
		"./assets/img/logo/mp4upload.png",
		"./assets/img/logo/mymailru.png",
		"./assets/img/logo/okru.png",
		"./assets/img/logo/onedrive.png",
		"./assets/img/logo/pandafiles.png",
		"./assets/img/logo/pcloud.png",
		"./assets/img/logo/racaty.png",
		"./assets/img/logo/rumble.png",
		"./assets/img/logo/sendvid.png",
		"./assets/img/logo/sibnet.png",
		"./assets/img/logo/solidfiles.png",
		"./assets/img/logo/soundcloud.png",
		"./assets/img/logo/streamable.png",
		"./assets/img/logo/streamff.png",
		"./assets/img/logo/streamlare.png",
		"./assets/img/logo/streamsb.png",
		"./assets/img/logo/streamtape.png",
		"./assets/img/logo/supervideo.png",
		"./assets/img/logo/tiktok.png",
		"./assets/img/logo/uploadbuzz.png",
		"./assets/img/logo/uploadsmobi.png",
		"./assets/img/logo/upstream.png",
		"./assets/img/logo/uptobox.png",
		"./assets/img/logo/uqload.png",
		"./assets/img/logo/userscloud.png",
		"./assets/img/logo/videobin.png",
		"./assets/img/logo/vidio.png",
		"./assets/img/logo/vidoza.png",
		"./assets/img/logo/vimeo.png",
		"./assets/img/logo/viu.png",
		"./assets/img/logo/voe.png",
		"./assets/img/logo/vudeo.png",
		"./assets/img/logo/vupto.png",
		"./assets/img/logo/yadisk.png",
		"./assets/img/logo/yourupload.png",
		"./assets/img/logo/youtube.png",
		"./assets/img/logo/zippyshare.png",
		"./assets/img/logo/zplayer.png",
		"./assets/img/logo/vidmoly.png",
		"./assets/img/logo/dropload.png",
		"./assets/img/logo/highload.png",
		"./assets/img/logo/letsupload.png",
		"./assets/img/logo/megaupload.png",
		"./assets/img/logo/openload.png",
		"./assets/img/logo/rapidshare.png",
		"./assets/img/logo/streamhide.png",
		"./assets/img/logo/streamvid.png",
		"./assets/img/logo/upvid.png",
		"./assets/img/logo/vtube.png",
		"./assets/img/logo/ydb.png",
		"./assets/img/logo/ytdlp.png",
	],
	assets = ["./offline.html"].concat(css, js, img),
	enabledCaches = ["script", "style", "font", "manifest", "image"];

self.addEventListener("install", function (e) {
	e.waitUntil(
		caches.open(CURRENT_CACHES.prefetch).then(function (cache) {
			const stack = [];
			assets.forEach(function (file) {
				stack.push(
					cache.add(file).catch(function (_) {
						console.error("can't load " + file + " to cache");
					})
				);
			});
		})
	);
});

self.addEventListener("activate", function (e) {
	e.waitUntil(
		caches.keys().then(function (keys) {
			return Promise.all(
				keys
					.filter(function (key) {
						return (
							key !== CURRENT_CACHES.prefetch &&
							key !== CURRENT_CACHES.dynamic
						);
					})
					.map(function (key) {
						return caches.delete(key);
					})
			);
		})
	);
});

self.addEventListener("fetch", function (e) {
	if (
		enabledCaches.indexOf(e.request.destination) > -1 &&
		!e.request.redirected
	) {
		e.respondWith(
			caches
				.match(e.request)
				.then(function (cacheRes) {
					return (
						cacheRes ||
						fetch(e.request)
							.then(function (fetchRes) {
								if (
									!fetchRes.redirected &&
									includeURLs(e.request.url) &&
									(fetchRes.status === 200 ||
										fetchRes.status === 0)
								) {
									return caches
										.open(CURRENT_CACHES.dynamic)
										.then(function (cache) {
											cache.put(
												e.request.url,
												fetchRes.clone()
											);
											return fetchRes;
										});
								} else {
									return fetchRes;
								}
							})
							.catch(function () {
								return;
							})
					);
				})
				.catch(function () {
					return;
				})
		);
	} else {
		return;
	}
});

function includeURLs(url) {
	return (
		url.indexOf("//" + location.hostname + "/") > -1 ||
		url.indexOf("cdn.jsdelivr.net") > -1 ||
		url.indexOf("cdnjs.cloudflare.com") > -1 ||
		url.indexOf(".wp.com") > -1 ||
		url.indexOf("image.filemanager") > -1
	);
}
