docker build -t lualatex-latest .

docker run --rm -v "$(pwd)":/data lualatex-latest