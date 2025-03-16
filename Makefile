BUILDDIR = `pwd`/build
DOCKER_IMAGE = latex-builder
LATEX_OPTIONS = -pdf
#  -interaction=nonstopmode
PACKAGE_NAME = WUSTReport

SOURCE_DIRS = $(shell ls -d */ | grep -v "^build")
SOURCE_TEXS = $(SOURCE_DIRS:=Report/main.tex)
PDFBUILDS = $(addprefix $(BUILDDIR)/, $(SOURCE_DIRS:/=.pdf))


.DEFAULT_GOAL := docker


.PHONY : clean
clean :
	-rm -r $(BUILDDIR) $(PACKAGE_NAME).sty


.PHONY : all
all : $(PDFBUILDS)


.PHONY : sty
sty : $(PACKAGE_NAME).sty
$(PACKAGE_NAME).sty : $(PACKAGE_NAME).ins $(PACKAGE_NAME).dtx
	mkdir -p $(BUILDDIR)
	yes | latex -output-directory=$(BUILDDIR) $(PACKAGE_NAME).ins
	cp $(BUILDDIR)/$@ $@


$(PDFBUILDS) : $(BUILDDIR)/%.pdf: $(PACKAGE_NAME).sty %/Report/main.tex
	mkdir -p $(BUILDDIR)
	cp logo-pwr-2016.pdf $(BUILDDIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=$* \
		-output-directory=$(BUILDDIR) \
		$*/Report/main


.PHONY : hadolint
hadolint : Dockerfile
	docker run --rm --interactive hadolint/hadolint < Dockerfile


.PHONY : image
image : Dockerfile
	docker build \
		--tag $(DOCKER_IMAGE) \
		.


.PHONY : docker
docker : image ## Compile the project via the latex-builder docker image
	docker run \
		--rm \
		--interactive \
		--workdir /data \
		--volume `pwd`:/data \
		--name=$(DOCKER_IMAGE) \
		$(DOCKER_IMAGE) \
		sh -c "make all"
