BUILD_DIR = `pwd`/build
OUT_DIR   = `pwd`/out

DOCKER_IMAGE = latex-builder
LATEX_OPTIONS = -xelatex
#  -interaction=nonstopmode
PACKAGE_NAME = WUSTReport

LAB_DIRS = \
	01_Direct-Methods-for-Solving-Linear-Systems \
	02_Eigenproblems \
	03_Ill-posed-least-squares-problems \
	04_Undetermined-and-constrained-linear-systems \
	05_Iterative-linear-solvers \
	06_Linear-programming \
	07_Unconstrained-Optimization \
	08_Nonlinear-equations

LAB_PDFS  = $(addprefix $(BUILD_DIR)/, $(addsuffix .pdf, $(LAB_DIRS)))
GABOR_PDFS = $(BUILD_DIR)/Gabor_Report_1.pdf $(BUILD_DIR)/Gabor_Report_2.pdf $(BUILD_DIR)/Gabor_Report_3.pdf
PRESENTATION_PDF = $(BUILD_DIR)/Project-Presentation.pdf
EXAM_PDF = $(BUILD_DIR)/Exam.pdf
PDFBUILDS  = $(LAB_PDFS) $(GABOR_PDFS) $(PRESENTATION_PDF) $(EXAM_PDF)


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


$(BUILD_DIR)/Gabor_Report_1.pdf : $(PACKAGE_NAME).sty Gabor_Report_1/main.tex
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Gabor_Report_1 \
		-output-directory=$(BUILD_DIR) \
		Gabor_Report_1/main
	cp $(BUILD_DIR)/Gabor_Report_1.pdf $(OUT_DIR)/Gabor_Report_1.pdf


NEWPWR_DEPS = $(wildcard Project/beamer*NewPwr.sty) \
              Project/slajd-en.png Project/tyt-en.png Project/Hr_p3.pdf

$(PRESENTATION_PDF) : Project/presentation.tex $(NEWPWR_DEPS)
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Project-Presentation \
		-output-directory=$(BUILD_DIR) \
		Project/presentation
	cp $(BUILD_DIR)/Project-Presentation.pdf $(OUT_DIR)/Project-Presentation.pdf


$(BUILD_DIR)/Gabor_Report_2.pdf : $(PACKAGE_NAME).sty Gabor_Report_2/main.tex
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Gabor_Report_2 \
		-output-directory=$(BUILD_DIR) \
		Gabor_Report_2/main
	cp $(BUILD_DIR)/Gabor_Report_2.pdf $(OUT_DIR)/Gabor_Report_2.pdf


$(EXAM_PDF) : Exam/main.tex Exam/01_direct_methods.tex Exam/02_eigenproblems.tex Exam/bibliography.bib
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Exam \
		-output-directory=$(BUILD_DIR) \
		Exam/main
	cp $(BUILD_DIR)/Exam.pdf $(OUT_DIR)/Exam.pdf


$(BUILD_DIR)/Gabor_Report_3.pdf : $(PACKAGE_NAME).sty Gabor_Report_3/main.tex
	mkdir -p $(BUILD_DIR) $(OUT_DIR)
	cp logo-pwr-2016.pdf $(BUILD_DIR)/
	latexmk $(LATEX_OPTIONS) \
		-cd \
		-jobname=Gabor_Report_3 \
		-output-directory=$(BUILD_DIR) \
		Gabor_Report_3/main
	cp $(BUILD_DIR)/Gabor_Report_3.pdf $(OUT_DIR)/Gabor_Report_3.pdf

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
