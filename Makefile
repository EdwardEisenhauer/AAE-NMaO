BUILD_DIR = `pwd`/build
OUT_DIR   = `pwd`/out

DOCKER_IMAGE = latex-builder
LATEX_OPTIONS = -xelatex
#  -interaction=nonstopmode
PACKAGE_NAME = WUSTReport

LAB_DIRS = \
	01_Direct-Methods-for-Solving-Linear-Systems \
	02_Eigenproblems \
	03_Ill-posed-least-squares-problems

LAB_PDFS  = $(addprefix $(BUILD_DIR)/, $(addsuffix .pdf, $(LAB_DIRS)))
GABOR_PDF = $(BUILD_DIR)/Gabor_Report_1.pdf
PDFBUILDS = $(LAB_PDFS) $(GABOR_PDF)


.DEFAULT_GOAL := all


clean :
	-rm -r $(BUILD_DIR) $(OUT_DIR) $(PACKAGE_NAME).sty
.PHONY : clean


all : $(PDFBUILDS)
.PHONY : all


sty : $(PACKAGE_NAME).sty
.PHONY : sty
$(PACKAGE_NAME).sty : $(PACKAGE_NAME).ins $(PACKAGE_NAME).dtx
	mkdir -p $(BUILD_DIR)
	yes | latex -output-directory=$(BUILD_DIR) $(PACKAGE_NAME).ins
	cp $(BUILD_DIR)/$@ $@


$(LAB_PDFS) : $(BUILD_DIR)/%.pdf: $(PACKAGE_NAME).sty %/Report/main.tex
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=$* \
		-output-directory=$(BUILD_DIR) \
		$*/Report/main
	cp $(BUILD_DIR)/$*.pdf $(OUT_DIR)/$*.pdf


$(GABOR_PDF) : $(PACKAGE_NAME).sty Gabor_Report_1/main.tex
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Gabor_Report_1 \
		-output-directory=$(BUILD_DIR) \
		Gabor_Report_1/main
	cp $(BUILD_DIR)/Gabor_Report_1.pdf $(OUT_DIR)/Gabor_Report_1.pdf

hadolint : Dockerfile
	docker run --rm --interactive hadolint/hadolint < Dockerfile
.PHONY : hadolint


image : Dockerfile
	docker build \
		--tag $(DOCKER_IMAGE) \
		.
.PHONY : image


docker : image ## Compile the project via the latex-builder docker image
	docker run \
		--rm \
		--interactive \
		--workdir /data \
		--volume `pwd`:/data \
		--name=$(DOCKER_IMAGE) \
		$(DOCKER_IMAGE) \
		sh -c "make all"
.PHONY : docker
