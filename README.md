# ubuntu-pkgsrc-bootstrap-kit-builder

Docker image to build a pkgsrc bootstrap kit for Ubuntu Linux.

## Usage

```sh
docker run -v /outdir:/packages \
    -e BOOTSTRAP_MAKE_JOBS=2 \
    -e PKGSRC_MAKE_JOBS=2 \
    minskim/ubuntu-pkgsrc-bootstrap-kit-builder:19.04
```
