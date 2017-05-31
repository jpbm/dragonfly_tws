cd output/
ffmpeg -framerate 3.8 -pattern_type glob -i '*.jpg' -c:v libx264 -pix_fmt yuv420p out_new.mp4
cd ..
mv output/out_new.mp4 .
