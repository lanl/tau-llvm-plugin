FROM dringo/tau-llvm-plugin:centos-dev

ARG TAU_VER=2.27.1
  
WORKDIR /tau

# the mpiinc shell variable is (hopefully) storing the include directory of
# whatever package provides the 'mpi-devel' capability.  If it's not set, the
# RUN command will fail.
RUN \
  mpiinc=$(dirname $(rpm -q -l $(rpm -q --whatprovides mpi-devel) | grep -e mpi\.h$)) \
  && [ "$mpiinc"x != x ] \
  && curl -SsL https://www.cs.uoregon.edu/research/tau/tau_releases/tau-${TAU_VER}.tar.gz \
     | tar xzf - --strip-components 2 ./tau-${TAU_VER} \
  && ./configure -mpi -mpiinc="$mpiinc" \
  && make \
  && make install
  

# IMPORTANT: the context for `docker build` should be the tau-llvm project root
COPY . /plugin

RUN \
  mkdir -p /plugin/build  \
  && cd /plugin/build \
  && cmake .. \
  && cmake --build .

WORKDIR /  
  
CMD ["/bin/bash"]
