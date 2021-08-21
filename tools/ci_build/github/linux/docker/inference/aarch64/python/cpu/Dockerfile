FROM quay.io/pypa/manylinux2014_aarch64:latest

ADD scripts /tmp/scripts
RUN cd /tmp/scripts && ./run.sh && cd / && rm -rf /tmp/scripts
