FROM dringo/tau-llvm-plugin:centos-pkg-base

ARG MAKE_J
ARG CMAKE_VER=3.10.3
ARG LLVM_VER=60

WORKDIR /tmp

# Get a recent version of CMake
RUN \
 git clone --recursive https://github.com/Kitware/CMake \
 && cd CMake \
 && git checkout v${CMAKE_VER} \
 && ./bootstrap \
 && make -j ${MAKE_J:-$(nproc)} \
 && make install \
 && rm -rf /tmp/CMake


# Get a recent version of LLVM
RUN \
 git clone --recursive https://github.com/llvm-mirror/llvm \
 && mkdir -p llvm/build \
 && cd llvm/build \
 && git checkout release_${LLVM_VER} \
 && cmake .. \
      -DCMAKE_C_COMPILER=clang \
      -DCMAKE_CXX_COMPILER=clang++ \
      -DCMAKE_BUILD_TYPE="Release" \
 && cmake --build . -- -j ${MAKE_J:-$(nproc)} \
 && cmake --build . --target install \
 && rm -rf /tmp/llvm

WORKDIR /

CMD ["/bin/bash"]
