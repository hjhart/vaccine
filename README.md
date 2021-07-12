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

```bash
doctl apps create --spec config/campground.rb
```

## New deployment after ./script/deploy

```bash
./script/deploy
doctl apps create-deployment 59f8270d-9812-4ffa-b3a6-fbc3deaee65f
```
