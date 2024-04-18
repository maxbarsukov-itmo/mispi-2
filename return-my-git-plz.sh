find src -type f ! -name '.keep' -delete

rm -rf .git

cp -r .rotter .git

rm -rf .rotter
