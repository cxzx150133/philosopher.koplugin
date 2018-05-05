# philosopher.koplugin

This is a plug-in for the KOReader that implements a random display of text from the TXT file.

The effect is similar to `hitokoto`([一言](http://hitokoto.cn/)),Print a random display of philosophical sentences,But it's a mobile app and this plug-in is for KOReader.

If you want to customize the output sentence, you can modify the contents of the **data.txt** file directly or modify the **TXT_File_Path** variable in the code to respecify the file path.

Default file path in line 13:
```lua
local TXT_File_Path   = "/mnt/onboard/.adds/koreader/plugins/philosopher.koplugin/data.txt"
```

## Supported formats

|   formats    |    date   |
|:------------:|:---------:|
|&#x2611; txt  | 2018/1/29 |
|&#x2610; json |  pending  |

## License
GPL v3
