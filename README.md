```bash
./script/build
```

```bash
docker run hjhart/vaccine:latest
```

```bash
docker run --rm hjhart/vaccine:latest ruby /usr/src/app/wa-state-campground.rb -c blake_island --start-date "18-06-2021" --end-date "20-06-2021" --party-size 4
```

```
docker run --rm hjhart/vaccine:latest ruby /usr/src/app/recreation_gov.rb -ccougar_rock
```

```bash
./script/deploy
```

```
HEADLESS=false ruby wa-state-campground.rb -c blake_island --start-date "20-08-2021" --end-date "22-08-2021" --party-size 2
```

```
HEADLESS=false kimurai console --engine selenium_chrome --url https://www.recreation.gov/camping/campsites/77506
```

## Deploy new instance to Digital Ocean

doctl apps create --spec config/campground.yml

````

## New deployment after ./script/deploy

```bash
./script/deploy
````
