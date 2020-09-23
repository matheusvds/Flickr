import Foundation

let getSizesJSON =
"""
{
    "sizes": {
        "canblog": 0,
        "canprint": 0,
        "candownload": 1,
        "size": [
            {
                "label": "Square",
                "width": 75,
                "height": 75,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_s.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/sq/",
                "media": "photo"
            },
            {
                "label": "Large Square",
                "width": 150,
                "height": 150,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_q.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/q/",
                "media": "photo"
            },
            {
                "label": "Thumbnail",
                "width": 100,
                "height": 56,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_t.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/t/",
                "media": "photo"
            },
            {
                "label": "Small",
                "width": 240,
                "height": 135,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_m.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/s/",
                "media": "photo"
            },
            {
                "label": "Small 320",
                "width": 320,
                "height": 180,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_n.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/n/",
                "media": "photo"
            },
            {
                "label": "Small 400",
                "width": 400,
                "height": 225,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_w.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/w/",
                "media": "photo"
            },
            {
                "label": "Medium",
                "width": 500,
                "height": 281,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/m/",
                "media": "photo"
            },
            {
                "label": "Medium 640",
                "width": 640,
                "height": 360,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_z.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/z/",
                "media": "photo"
            },
            {
                "label": "Medium 800",
                "width": 800,
                "height": 450,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_c.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/c/",
                "media": "photo"
            },
            {
                "label": "Large",
                "width": 1024,
                "height": 576,
                "source": "https://live.staticflickr.com/5800/31456463045_5a0af4ddc8_b.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/l/",
                "media": "photo"
            },
            {
                "label": "Large 1600",
                "width": 1600,
                "height": 900,
                "source": "https://live.staticflickr.com/5800/31456463045_5c3cd7e224_h.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/h/",
                "media": "photo"
            },
            {
                "label": "Large 2048",
                "width": 2048,
                "height": 1152,
                "source": "https://live.staticflickr.com/5800/31456463045_3acfddf6e2_k.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/k/",
                "media": "photo"
            },
            {
                "label": "X-Large 3K",
                "width": 3072,
                "height": 1728,
                "source": "https://live.staticflickr.com/5800/31456463045_432b1bc25f_3k.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/3k/",
                "media": "photo"
            },
            {
                "label": "X-Large 4K",
                "width": 4096,
                "height": 2304,
                "source": "https://live.staticflickr.com/5800/31456463045_01cb808199_4k.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/4k/",
                "media": "photo"
            },
            {
                "label": "X-Large 5K",
                "width": 4608,
                "height": 2592,
                "source": "https://live.staticflickr.com/5800/31456463045_3140fd974f_5k.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/5k/",
                "media": "photo"
            },
            {
                "label": "Original",
                "width": 4608,
                "height": 2592,
                "source": "https://live.staticflickr.com/5800/31456463045_fe2ef86591_o.jpg",
                "url": "https://www.flickr.com/photos/alex53/31456463045/sizes/o/",
                "media": "photo"
            }
        ]
    },
    "stat": "ok"
}
"""
