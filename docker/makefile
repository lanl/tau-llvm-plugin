DOCKERFILES = $(wildcard *.Dockerfile)
IMAGES = $(patsubst %.Dockerfile,%, $(DOCKERFILES))
STAMPD = .stamps
STAMPS = $(IMAGES:%=$(STAMPD)/%.stamp)
PUSH_ALL = $(IMAGES:%=%-push)
REPO=dringo/tau-llvm-plugin

# build arguments can be passed to `docker build`, if necessary.
#
# `make BUILDARGS="foo=GOO bar=WAR"` will invoke docker build with two `--build-arg`
# instances:
#
#  docker build --build-arg foo=GOO bar=WAR
#
# Unfortunately, make will never play well with whitespace that needs to be
# embedded in such an argument
BUILDARGS =

all: plugin

push: $(PUSH_ALL)

$(PUSH_ALL): IMG=$(@:%-push=%)
$(PUSH_ALL): %-push : %
	docker push $(REPO):$(IMG)

# dummy stamp files to keep the dependencies in order
$(IMAGES): % : $(STAMPD)/%.stamp

# Dependencies in images are in the form "target~dependency" here
define DEPS
plugin~centos-dev\
centos-dev~centos-pkg-base\
bar~foo
endef

# use coreutils to pull the dependency/target from the string
getdep=$(shell echo $(1) | cut -d~ -f2)
gettrg=$(shell echo $(1) | cut -d~ -f1)

define mkdep
$$(STAMPD)/$(call gettrg,$(1)).stamp: $$(STAMPD)/$(call getdep,$(1)).stamp
endef

$(foreach dep, $(DEPS), $(eval $(call mkdep, $(dep))))

$(STAMPS): IMG=$(@:$(STAMPD)/%.stamp=%)
$(STAMPS): $(STAMPD)/%.stamp : %.Dockerfile | $(STAMPD)
	docker build $(BUILDARGS:%=--build-arg %) \
		-t $(REPO):$(IMG) \
		-f $(IMG).Dockerfile ..
	touch $@


$(STAMPD):
	mkdir -p $(STAMPD)
