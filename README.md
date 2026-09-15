# units.koplugin - lightweight units conversion for KOReader

This plugin is an extremely lightweight alternative to
<https://github.com/ultimatejimmy/xray.koplugin> or
<https://github.com/Fank1/foot-cream>
— convert units in highlighted (selected) text, and nothing else.

- no background scanning
- no online features
  - no AI
  - no background checking for updates
- no epub rewriting
- no monkeypatching of KOReader internals
- no configuration

It does one thing only: when you select a text, there's an extra "Convert units" button.

Internally, it uses the logic from <https://github.com/ultimatejimmy/xray.koplugin>.
(It's easy to reuse, just one file, thanks!)

## FAQ

> Why doesn't it recognise and convert "40 degrees", assuming it's the foreign temperature scale?

Because xray.koplugin doesn't. There's a workaround, though:

1. save the Highlight
2. tap it and go to Details
3. tap the Edit text button
4. change it to "40 degrees f" instead
5. close the dialog
6. tap the highlight again
7. tap the … button
8. try Convert units again

Should work for any other unit that isn't recognised, such as "sqft" without the space.
