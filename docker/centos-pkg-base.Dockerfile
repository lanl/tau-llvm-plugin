FROM centos:7

#  - enable and reinstall docs (man/info pages) for centos newbies like me
#  - install a basic development environment + clang + MPI
RUN \
 sed -i 's/\(tsflags=nodocs\)/# \1/' /etc/yum.conf \
 && yum reinstall -y '*' \
 && yum install -y man man-pages openmpi-devel clang which \
 && yum group install -y "Development Tools"

CMD ["/bin/bash"]
