FROM justincormack/rumprun

MAINTAINER Justin Cormack <justin@specialbusservice.com>

COPY . /usr/src/rumprun-packages-hw

WORKDIR /usr/src/rumprun-packages-hw

ENV PATH=/usr/src/rumprun-hw/app-tools:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin RUMPRUN_WARNING_STFU=please

RUN printf "RUMPRUN_TOOLCHAIN_TUPLE=x86_64-rumprun-netbsd" > config.mk

# very slow
RUN rm -rf rust

RUN make world

RUN for f in */bin/*; do [ -x $f ] && rumpbake hw_generic $f.hw_generic $f; rumpbake hw_virtio $f.hw_virtio $f; done
