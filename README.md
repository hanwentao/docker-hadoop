# Hadoop in Docker

This project aims to run Hadoop in Docker containers.

## Usage

1. Download Hadoop binary package.

```
./download-packages.sh
```

2. Launch containers by docker-compose.

```
cd cluster
docker-compose up -d --build
```

And enjoy yourself!
