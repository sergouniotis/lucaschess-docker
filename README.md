# LucasChess Docker

This is a try to dockerize the [lucas chess game](https://github.com/lukasmonk/lucaschess)

## Prerequisites
Use the latest version of 

	- Docker
	- docker-compose ( optional )

## Installation

Use the package manager [docker](https://www.docker.com/) to build the docker image.

```bash
docker build -t lucaschess .
```

## Usage

```bash
docker run --name lucaschess --network host -it --rm -e DISPLAY=$DISPLAY -e QT_X11_NO_MITSHM=1 -v /tmp/.X11-unix:/tmp/.X11-unix lucaschess

```

## Contributing
Pull requests are welcome. 

## License
[GPL-2.0](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

