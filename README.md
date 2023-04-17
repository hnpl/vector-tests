# vector-tests

To compile the tests, you should have a docker image containing the RISC-V gcc cross compiler.

In the `vector-tests` folder,

```sh
docker run -u $UID:$GID --volume $PWD:/workdir -w /workdir --rm -it hn/gcc-rvv
make -j `nproc`
```

The makefile also calls `./verify-compilation.sh`, which verifies if the binaries contain vector instructions.

**Note**: Having static vector instructions does not guarantee there'll be dynamic vector instructions!
