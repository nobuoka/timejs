time.js
=======

## Usage

```html
<script>
  window.onload = function () {
    new TER (document.body);
  };
</script>
<script src="http://suika.fam.cx/www/style/ui/time.js.u8" charset=utf-8></script>

<time>2008-12-20T23:27+09:00</time>
<!-- Will be rendered appropriately in the user's locale -->
```

... or:

```html
<script>
  window.onload = function () {
    new TER.Delta (document.body);
  };
</script>
<script src="http://suika.fam.cx/www/style/ui/time.js.u8" charset=utf-8></script>

<time>2008-12-20T23:27+09:00</time>
<!-- Will be rendered like "2 minutes ago" in English or Japanese -->
```

This script supports the HTML `time` element, which is a willful
violation to the HTML Living Standard as of October 30, 2011.

This script interprets "global date and time string" using older
parsing rules as defined in previous versions of the HTML spec, which
is a willful violation to the current HTML Living Standard.

## LICENSE

See: [LICENSE file](./LICENSE)
