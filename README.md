```bash
./script/build
```

```bash
docker run vaccine:latest
```

```bash
docker run --rm hjhart/vaccine:latest ruby /usr/src/app/blake-island.rb -c -2147483640 --start-date "18-06-2021" --end-date "20-06-2021" --party-size 4
```

```bash
./script/deploy
```

```
HEADLESS=false ruby blake-island.rb --start-date "20-08-2021" --end-date "22-08-2021" --party-size 2
```

## Deploy new instance to Digital Ocean

doctl apps create --spec config/campground.rb

````

## New deployment after ./script/deploy

```bash
./script/deploy
````
