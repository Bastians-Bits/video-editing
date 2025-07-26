# Default
```
video-compare -d -W left.mkv right.mkv
```

# With Cropping
Get cropping
```
ffplay -i video.mkv -vf cropdetect
```
Copy Cropping Part in the Output
```
video-compare -d -W [-l crop=1920:800:0:140][-r crop=1920:800:0:140]] left.mkv right.mkv
```
