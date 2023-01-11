start:
	conc -n "elm,http" "elm-watch hot" "serve -p 5000 -s"

build:
	elm make src/Main.elm --optimize --output=dist/main.js


